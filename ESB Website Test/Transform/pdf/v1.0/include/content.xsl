<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <content>
		| Generate content
		+-->
	<xsl:template match="/" mode="content">
		
		<!--+
			| Generate table of contents block
			+-->
		<fo:block-container>
			<!-- Generate background -->
			<xsl:call-template name="background"/>
			
			<fo:block id="{$toc_toc}" font-size="32pt" margin-top="1cm">
				<xsl:value-of select="$toc_toc"/>
			</fo:block>
			
			<!-- TOC -->
			<fo:block text-align-last="justify">
				<fo:basic-link internal-destination="{$toc_toc}">
					<xsl:value-of select="$toc_toc"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_toc}"/>
				</fo:basic-link>
			</fo:block>
			
			<!-- Introduction -->
			<fo:block text-align-last="justify">
				<fo:basic-link internal-destination="{$toc_introduction}">
					<xsl:value-of select="$toc_introduction"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_introduction}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_introduction_description}">
					<xsl:value-of select="$toc_introduction_description"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_introduction_description}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_introduction_history}">
					<xsl:value-of select="$toc_introduction_history"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_introduction_history}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_introduction_notes}">
					<xsl:value-of select="$toc_introduction_notes"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_introduction_notes}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_introduction_endpoints}">
					<xsl:value-of select="$toc_introduction_endpoints"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_introduction_endpoints}"/>
				</fo:basic-link>
			</fo:block>
				
			<!-- Configuration-->
			<fo:block text-align-last="justify">
				<fo:basic-link internal-destination="{$toc_configuration}">
					<xsl:value-of select="$toc_configuration"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_configuration}"/>
				</fo:basic-link>
			</fo:block>
                
			<!-- Installation -->
			<fo:block text-align-last="justify">
				<fo:basic-link internal-destination="{$toc_installation}">
					<xsl:value-of select="$toc_installation"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_installation}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_installation_console}">
					<xsl:value-of select="$toc_installation_console"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_installation_console}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_installation_fabric}">
					<xsl:value-of select="$toc_installation_fabric"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_installation_fabric}"/>
				</fo:basic-link>
			</fo:block>
				
			<!-- Appendix -->
			<fo:block text-align-last="justify">
				<fo:basic-link internal-destination="{$toc_appendix}">
					<xsl:value-of select="$toc_appendix"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_appendix}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_appendix_jks}">
					<xsl:value-of select="$toc_appendix_jks"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_appendix_jks}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_appendix_cron}">
					<xsl:value-of select="$toc_appendix_cron"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_appendix_cron}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_appendix_transactional}">
					<xsl:value-of select="$toc_appendix_transactional"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_appendix_transactional}"/>
				</fo:basic-link>
			</fo:block>
			<fo:block text-align-last="justify" margin-left="10pt">
				<fo:basic-link internal-destination="{$toc_appendix_allowed_messages}">
					<xsl:value-of select="$toc_appendix_allowed_messages"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{$toc_appendix_allowed_messages}"/>
				</fo:basic-link>
			</fo:block>
			
		</fo:block-container>
	
		<!--+
			| Generate introduction block
			+-->
		<fo:block-container break-before="page">
			<!-- Generate background -->
			<xsl:call-template name="background"/>
			
			<fo:block id="{$toc_introduction}" font-size="32pt" margin-top="1cm">
				<xsl:value-of select="$toc_introduction"/>
			</fo:block>
			<xsl:apply-templates mode="introduction" select="/"/>
		</fo:block-container>
		
		<!--+
			| Generate configuration block
			+-->
		<fo:block-container break-before="page">
			<!-- Generate background -->
			<xsl:call-template name="background"/>
			
			<fo:block id="{$toc_configuration}" font-size="32pt" margin-top="1cm">
				<xsl:value-of select="$toc_configuration"/>
			</fo:block>
			<xsl:apply-templates mode="configuration" select="/"/>
		</fo:block-container>
		
		<!--+
			| Generate installation block
			+-->
		<fo:block-container break-before="page">
			<!-- Generate background -->
			<xsl:call-template name="background"/>
			
			<fo:block id="{$toc_installation}" font-size="32pt" margin-top="1cm">
				<xsl:value-of select="$toc_installation"/>
			</fo:block>
			<xsl:apply-templates mode="installation" select="/"/>
		</fo:block-container>
		
		<!--+
			| Generate appendix block
			+-->
		<fo:block-container break-before="page">
			<!-- Generate background -->
			<xsl:call-template name="background"/>
			
			<fo:block id="{$toc_appendix}" font-size="32pt" margin-top="1cm">
				<xsl:value-of select="$toc_appendix"/>
			</fo:block>
			<xsl:apply-templates mode="appendix" select="/"/>
		</fo:block-container>
    	
    	<!--+
    		| Marker for page numbering
    		+-->
    	<fo:block id="content_terminator"/>
	</xsl:template>
	
	<!--+
		| [*] <content>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="content"/>
	
</xsl:stylesheet>
