<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <appendix>
		| Generate content for appendix
		+-->
	<xsl:template match="/" mode="appendix">
	
		<fo:block id="toc_appendix_x">
			
			<!-- JKS -->
			<fo:block id="{$toc_appendix_jks}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_appendix_jks"/>
			</fo:block>
			<fo:block>
				<xsl:text>This section describes creating Java key stores which are required by the ESB in order to handle SSL traffic.</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:text>The following link provides more information:</xsl:text>
			</fo:block>
			<fo:block>
				<fo:basic-link external-destination="http://ams-build01:8081/esbdev/releasedocs/Generic%20documentation%20for%20exporting%20%20certificates.pdf" text-decoration="underline">
					<xsl:text>- Exporting SSL certificates</xsl:text>
				</fo:basic-link>
			</fo:block>
			
			<!-- Cron timers -->
			<fo:block id="{$toc_appendix_cron}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_appendix_cron"/>
			</fo:block>
			<fo:block>
				<xsl:text>This section describes configuring cron timers on the ESB.</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:text>The following links provide more information:</xsl:text>
			</fo:block>
			<fo:block>
				<fo:basic-link external-destination="http://camel.apache.org/quartz2.html#Quartz2-UsingCronTriggers" text-decoration="underline">
					<xsl:text>- Camel quartz cron triggers</xsl:text>
				</fo:basic-link>
			</fo:block>
			<fo:block>
				<fo:basic-link external-destination="http://www.quartz-scheduler.org/documentation/quartz-2.1.x/tutorials/crontrigger" text-decoration="underline">
					<xsl:text>- Quartz scheduler</xsl:text>
				</fo:basic-link>
			</fo:block>
			
			<!-- Transactional routes -->
			<fo:block id="{$toc_appendix_transactional}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_appendix_transactional"/>
			</fo:block>
			<fo:block>
				<xsl:text>This section is about transactional routes, which plays an important role on the ESB. The primary reason is to preserve the messages </xsl:text>
				<xsl:text>on an input queue by performing a roll back and a shutdown of the route.</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:text>The following link provides more information:</xsl:text>
			</fo:block>
			<fo:block>
				<fo:basic-link external-destination="http://ams-build01:8081/esbdev/releasedocs/Generic%20documentation%20for%20transaction%20enabled%20endpoints%201.0.0.pdf" text-decoration="underline">
					<xsl:text>- Transactional endpoints</xsl:text>
				</fo:basic-link>
			</fo:block>
			
			<!-- Allowed messages -->
			<fo:block id="{$toc_appendix_allowed_messages}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_appendix_allowed_messages"/>
			</fo:block>
			<fo:block>
				<xsl:text>The allowed messages is a configuration file which defines what messages and what versions are allowed on the ESB.</xsl:text>
			</fo:block>
			<fo:block margin-top="5mm">
				<xsl:text>The following link provides an example:</xsl:text>
			</fo:block>
			<fo:block>
				<fo:basic-link external-destination="http://ams-build01:8081/esbdev/configuration-files/validation/ams-jbf-d03/d03-esb-ws-endpoint-1.0.0-allowedMessages.xml" text-decoration="underline">
					<xsl:text>- Example file</xsl:text>
				</fo:basic-link>
			</fo:block>
		</fo:block>
	</xsl:template>
	
	<!--+
		| [*] <appendix>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="appendix"/>
	
</xsl:stylesheet>
