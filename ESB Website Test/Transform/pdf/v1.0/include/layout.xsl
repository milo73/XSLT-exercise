<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
	
	<!--+
		| [/] <layout>
		| Root matcher
		+-->
	<xsl:template match="/" mode="layout">
		<fo:layout-master-set>
			
			<fo:simple-page-master master-name="first" page-width="21cm" page-height="29.7cm" margin-right="5mm" margin-left="5mm" margin-top="5mm" margin-bottom="5mm">
				<fo:region-body region-name="first_body" margin-bottom="4.5in" margin-left="5mm" margin-top="1.5cm"/>
				<fo:region-before region-name="first_before" extent="1cm"/>
				<fo:region-after region-name="first_after" extent="1.5cm"/>				
			</fo:simple-page-master>
			
			<fo:simple-page-master master-name="rest" page-width="21cm" page-height="29.7cm" margin-right="5mm" margin-left="5mm" margin-top="5mm" margin-bottom="5mm">
				<fo:region-body region-name="rest_body" margin-bottom="2cm" margin-left="5mm" margin-top="1.4cm"/>
				<fo:region-before region-name="rest_before" extent="1cm"/>
				<fo:region-after region-name="rest_after" extent="1.5cm"/>
			</fo:simple-page-master>
			
			<fo:page-sequence-master master-name="title-page">
				<fo:single-page-master-reference master-reference="first"/>
			</fo:page-sequence-master>
			
			<fo:page-sequence-master master-name="other-pages">
				<fo:repeatable-page-master-reference master-reference="rest"/>
			</fo:page-sequence-master>
			
		</fo:layout-master-set>
	</xsl:template>
	
	<!--+
		| [*] <layout>
		| Default matcher, absorb
		+-->
	<xsl:template match="*" mode="layout"/>
	
</xsl:stylesheet>
