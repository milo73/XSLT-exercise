<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<title>Page not supported</title>
				<link href="css/stylesheet.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="page">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="quote">
		<div class="hugebold">
			<xsl:value-of select="."/>
		</div>
		<div class="huge">
			<xsl:value-of select="concat(@author, ' (', @movie, '~', @year, ')')"/>
		</div>
	</xsl:template>
	
	<xsl:template match="*"/>
	
</xsl:stylesheet>