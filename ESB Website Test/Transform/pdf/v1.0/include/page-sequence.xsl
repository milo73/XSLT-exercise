<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <sequence>
		| Root matcher
		+-->
	<xsl:template match="/" mode="sequence">
		
		<!-- Generate title page -->
		<fo:page-sequence master-reference="title-page">
			<fo:flow flow-name="first_body">
				<xsl:apply-templates mode="title" select="/"/>
			</fo:flow>
		</fo:page-sequence>
		
		<!-- Generate other pages -->
		<fo:page-sequence master-reference="other-pages">
			
			<!-- Static header -->
			<fo:static-content flow-name="rest_before">
				<fo:block text-align="end" font-size="9pt" font-family="serif" line-height="14pt" color="{$header-colour}">
					<xsl:value-of select="concat(dtg:route/dtg:maven/@groupId, '/', dtg:route/dtg:maven/@artifactId, '/', $param_artifact_version)"/>
				</fo:block>
			</fo:static-content>
			
			<!-- Static footer -->
			<fo:static-content flow-name="rest_after">
				<fo:block line-height="14pt" font-size="10pt" text-align="center" color="{$footer-colour}">
					<xsl:value-of select="'page '"/>
					<fo:page-number/>
					<xsl:value-of select="' of '"/>
					<fo:page-number-citation ref-id="content_terminator"/>
				</fo:block>
			</fo:static-content>
			
			<!-- Pages -->
			<fo:flow flow-name="rest_body" font-size="12pt">
				<!-- Generate content -->
				<xsl:apply-templates mode="content" select="/"/>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<!--+
		| [*] <sequence>
		| Default matcher, absorb
		+-->
	<xsl:template match="*" mode="sequence"/>
	
</xsl:stylesheet>
