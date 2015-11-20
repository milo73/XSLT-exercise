<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <content>
		| Generate content for installation
		+-->
	<xsl:template match="/" mode="installation">
	
		<fo:block id="toc_installation_x">
			
			<fo:block>
				<xsl:text>Installation, depending on environment, can occur in one of the following ways, by karaf console or fabric. For completeness of this </xsl:text>
				<xsl:text>generated documentation, both principles are described.</xsl:text>
			</fo:block>
			
			<fo:block id="{$toc_installation_console}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_installation_console"/>
			</fo:block>
			<fo:block>
				<xsl:text>In case the artifact is installed as a feature the following commands need to be issued on the karaf console. </xsl:text>
				<xsl:text>Keep in mind that any properties need to be set first, before the route is started. Also, when applicable, the older </xsl:text>
				<xsl:text>version of the route must be un-installed and removed. The commands then are: </xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:value-of select="concat('- features:uninstall ', dtg:route/dtg:maven/@artifactId)"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="concat('- features:removeurl mvn:', dtg:route/dtg:maven/@groupId, '/', dtg:route/dtg:maven/@artifactId, '/OLD_VERSION/xml/features')"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="concat('- features:addurl mvn:', dtg:route/dtg:maven/@groupId, '/', dtg:route/dtg:maven/@artifactId, '/', $param_artifact_version, '/xml/features')"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="concat('- features:install ', dtg:route/dtg:maven/@artifactId)"/>
			</fo:block>
			
			<fo:block id="{$toc_installation_fabric}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_installation_fabric"/>
			</fo:block>
			<fo:block>
				<xsl:text>Ensure a profile exists, or more precisely, a directory on file system including version number (such as: .../dtg-ci-esbi/1.0/...)</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:text>Update the repositories.txt file, the features.txt file and then execute the push script to update the profile in fabric. To summarize:</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:value-of select="concat('- add the feature to the features.txt file: ', dtg:route/dtg:maven/@artifactId)"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="concat('- add the repositiry to the reposities.txt file: mvn:', dtg:route/dtg:maven/@groupId, '/', dtg:route/dtg:maven/@artifactId, '/', $param_artifact_version, '/xml/features')"/>
			</fo:block>
			
		</fo:block>
		
	</xsl:template>
	
	<!--+
		| [*] <installation>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="installation"/>
	
</xsl:stylesheet>
