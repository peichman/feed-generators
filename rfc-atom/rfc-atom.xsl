<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:rfc="http://www.rfc-editor.org/rfc-index" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/2005/Atom"
  version="1.0">

  <xsl:param name="now"/>
  <xsl:param name="max">12</xsl:param>

  <xsl:template match="rfc:rfc-index">
    <feed>

      <title>Recent IETF RFCs</title>
      <link href="http://www.rfc-editor.org/rfc-index2.html"/>
      <updated><xsl:value-of select="$now"/></updated>
      <author>
        <name>Peter Eichman</name>
      </author>
      <id>http://echodin.net/feeds/rfc.atom</id>

      <xsl:apply-templates select="rfc:rfc-entry">
        <xsl:sort select="rfc:doc-id" order="descending"/>
      </xsl:apply-templates>
    </feed>
  </xsl:template>

  <xsl:template match="rfc:rfc-entry">
    <xsl:if test="position() &lt;= $max">
      <xsl:variable name="html-uri">http://tools.ietf.org/html/rfc<xsl:value-of select="substring-after(rfc:doc-id, 'RFC')"/></xsl:variable>
      <entry>
        <title><xsl:value-of select="rfc:doc-id"/>: <xsl:value-of select="rfc:title"/></title>
        <link href="{$html-uri}"/>
        <id><xsl:value-of select="$html-uri"/></id>
        <summary>
          (<xsl:apply-templates select="rfc:author"/>)
          <xsl:value-of select="rfc:abstract"/>
        </summary>
      </entry>
    </xsl:if>
  </xsl:template>

  <xsl:template match="rfc:author">
    <xsl:value-of select="rfc:name"/>
    <xsl:if test="position() != last()">, </xsl:if>
  </xsl:template>
</xsl:stylesheet>
