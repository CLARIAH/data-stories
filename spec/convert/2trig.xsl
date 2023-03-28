<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:ds="http://example.com/ds/" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:param name="base" select="base-uri(/*)"/>
    <xsl:param name="sep" select="system-property('file.separator')"/>
    
    <xsl:variable name="NL" select="system-property('line.separator')"/>
    <xsl:variable name="TAB" select="'  '"/>
    
    <xsl:template match="text()"/>
    
    <xsl:template match="/">
        <xsl:text expand-text="yes">
@prefix ds: &lt;http://example.com/ds/> .
@prefix dct: &lt;http://purl.org/dc/terms/> .
@prefix doc: &lt;{$base}#> .
        </xsl:text>
        <xsl:apply-templates/>
        <xsl:text expand-text="yes">.{$NL}</xsl:text>
    </xsl:template>
    
    <xsl:template match="ds:DataStory">
        <xsl:text expand-text="true">{$NL}&lt;{$base}> a ds:DataStory</xsl:text>
        <xsl:apply-templates>
            <xsl:with-param name="INDENT" select="''" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ds:Story">
        <xsl:param name="INDENT" tunnel="yes"/>
        <xsl:text expand-text="yes">;{$NL}{$INDENT}{$TAB}ds:hasStory doc:Story</xsl:text>
        <xsl:text expand-text="yes">.{$NL}{$NL}{$INDENT}doc:Story a ds:Story</xsl:text>
        <xsl:text expand-text="yes">;{$NL}{$INDENT}{$TAB}ds:hasBlock ( {string-join(for $b in ds:Block return concat('doc:',$b/@xml:id),' ')} )</xsl:text>
        <xsl:apply-templates>
            <xsl:with-param name="INDENT" select="'string-join(($INDENT,$TAB))'" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
        
</xsl:stylesheet>