<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://schema.detelefoongids.nl"
	xmlns:dtg="http://schema.detelefoongids.nl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0"
>
    <xsl:output method="html" omit-xml-declaration="yes" encoding="utf-8"/>

	<!--+
		| Route matcher, generate navigation menu, with a link for details for each route.
		+-->
	<xsl:template match="dtg:route" mode="menu">
		<xsl:param name="routeId"/>
		<xsl:variable name="selected">
			<xsl:choose>
				<xsl:when test="@id = $routeId">
					<xsl:text>leftmenu_option_selected</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>leftmenu_option</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="div">
			<xsl:attribute name="class">
				<xsl:value-of select="$selected"/>
			</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:value-of select="concat('/detail?routeId=', @id)"/>
				</xsl:attribute>
				<xsl:value-of select="@id"/>
			</xsl:element>
		</xsl:element>
		<div class="leftmenuSpacer">
			<xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
		</div>
	</xsl:template>
	
	<!-- Default matcher -->
	<xsl:template match="dtg:*" mode="menu"/>
	
</xsl:stylesheet>