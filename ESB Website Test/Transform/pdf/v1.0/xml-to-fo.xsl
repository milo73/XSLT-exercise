<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xmda="http://xsd.xmda.org/xmda/persistence"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
<!--
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/layout.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/page-sequence.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/background.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/title.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/content.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/content/introduction.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/content/configuration.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/content/installation.xsl"/>
	<xsl:include href="http://schema.detelefoongids.nl/translate/pdf/V1.0/include/content/appendix.xsl"/>
	-->

	<xsl:include href="include/layout.xsl"/>
	<xsl:include href="include/page-sequence.xsl"/>
	<xsl:include href="include/background.xsl"/>
	<xsl:include href="include/title.xsl"/>
	<xsl:include href="include/content.xsl"/>
	<xsl:include href="include/content/introduction.xsl"/>
	<xsl:include href="include/content/configuration.xsl"/>
	<xsl:include href="include/content/installation.xsl"/>
	<xsl:include href="include/content/appendix.xsl"/>
	
	<!-- Globals -->
	<xsl:variable name="header-colour" select="'rgb(150,150,150)'"/>
	<xsl:variable name="footer-colour" select="'rgb(150,150,150)'"/>
	<xsl:variable name="jiraHost" select="'https://jira.eurodir.eu/jira/browse/'"/>
	
	<xsl:variable name="toc_toc" select="'Table of contents'"/>
	<xsl:variable name="toc_introduction" select="'Introduction'"/>
	<xsl:variable name="toc_introduction_description" select="'Description'"/>
	<xsl:variable name="toc_introduction_history" select="'History'"/>
	<xsl:variable name="toc_introduction_notes" select="'Notes'"/>
	<xsl:variable name="toc_introduction_endpoints" select="'Endpoints'"/>
	<xsl:variable name="toc_configuration" select="'Configuration'"/>
	<xsl:variable name="toc_installation" select="'Installation'"/>
	<xsl:variable name="toc_installation_console" select="'Karaf console'"/>
	<xsl:variable name="toc_installation_fabric" select="'Fabric'"/>
	<xsl:variable name="toc_appendix" select="'Appendix'"/>
	<xsl:variable name="toc_appendix_jks" select="'Java keystores'"/>
	<xsl:variable name="toc_appendix_cron" select="'Cron timers'"/>
	<xsl:variable name="toc_appendix_transactional" select="'Transactional routes'"/>
	<xsl:variable name="toc_appendix_allowed_messages" select="'Allowed messages'"/>
	
	<!-- External paramaters -->
	<xsl:param name="param_tstamp"/>
	<xsl:param name="param_artifact_version"/>
	
	<!--+
		| [/]
		| Root matcher
		+-->
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!-- Generate page layouts -->
			<xsl:apply-templates mode="layout" select="."/>
			<!-- Generate page sequence -->
			<xsl:apply-templates mode="sequence" select="."/>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>