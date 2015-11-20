<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <title>
		| Generate title page
		+-->
	<xsl:template match="/" mode="title">
		<fo:block font-size="32pt" margin-top="75mm" text-align="center">
			<xsl:text>Artifact Configuration</xsl:text>
		</fo:block>
		<fo:block margin-top="5px" text-align="center">
			<xsl:value-of select="concat('Generated at: ' , $param_tstamp)"/>
		</fo:block>
	</xsl:template>
	
	<!--+
		| [*] <title>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="title"/>
	
</xsl:stylesheet>
