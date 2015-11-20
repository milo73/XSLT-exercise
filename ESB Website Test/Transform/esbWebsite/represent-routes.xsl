<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://schema.detelefoongids.nl"
	xmlns:dtg="http://schema.detelefoongids.nl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0"
>
	<xsl:include href="include/generate-menu.xsl"/>

    <xsl:output method="html" omit-xml-declaration="yes" encoding="iso-8859-1"/>
	
	<xsl:param name="labelId"/>
	
	<xsl:key name="supportedLabels" match="dtg:label" use="."/>

	<!--+
		| Root matcher, proceed with child nodes.
		+-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--+
		| Routes matcher, generate overview page.
		+-->
	<xsl:template match="routes">
		<html>
			<head>
				<title>DTG ESB Routes</title>
				<link href="/css/stylesheet.css" rel="Stylesheet"/>
			</head>
			<body>
				<div class="header">
					<div class="header_content">
						<div class="header_right">ESB Routes Information</div>
					</div>			
					<div class="header_line">
						<xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
					</div>
                    <div class="header_shade">
                        <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                    </div>
                </div>
				<div class="leftMenuPane">
					<div class="leftmenu_content">
						<div class="leftmenu_header">MENU</div>
						<div class="leftmenu_option">
							<a href="/overview">overview</a>
						</div>
						<div class="leftmenuSpacer">
							<xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
						</div>
						<xsl:apply-templates mode="menu"/>
					</div>
				</div>
				<div class="contentPane">
					<h1>Integration Overview</h1>
					<xsl:text>
						This website will give an overview of all the integrations that are currently running on the ESB
					</xsl:text>
					<br/>
					<xsl:text>
						Select any of the available routes on the left side of this page, to get a detailed overview of that specific route.
					</xsl:text>
					<p/>
				</div>
			</body>
		</html>
	</xsl:template>

	<!-- Default matchers -->	
	<xsl:template match="dtg:*"/>
	<xsl:template match="*"/>
	
</xsl:stylesheet>