<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   XSLT stylesheet that adds 'id' attribute to MusicXML 3.1 elements without any.
   Suitable for MusicXML Partwise files. 
   
   Only elements with 'id' or 'optional-unique-id' attribute group in XSD MusicXML 3.1 specification are processed. 
    Format of 'id' value is "name-XXXXX", where 'name' is the element name (e.g. 'note')
    and XXXXXX is a deterministic and unique alphanumeric string.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs"
   version="1.0">
   <xsl:output method="xml" indent="yes" encoding="UTF-8"
      omit-xml-declaration="no" standalone="no"
      doctype-system="http://www.musicxml.org/dtds/partwise.dtd"
      doctype-public="-//Recordare//DTD MusicXML 3.1 Partwise//EN" />
   
   <!--
      Identity template that will copy every
        attribute, element, comment, and processing instruction
        to the output
   -->
   <xsl:template match="@*|node()">
      <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
   </xsl:template>
   
   <!--
      Add 'id' attribute to elements if they do not have already one
   -->
   <xsl:template 
      match="bookmark|instrument|midi-instrument|part|play|score-instrument|score-part|clef|key|measure-style|time|transpose|barline|coda|dynamics|fermata|segno|direction|direction-type|rehearsal|words|wedge|dashes|bracket|pedal|metronome|octave-shift|harp-pedals|damp|damp-all|eyeglasses|string-mute|scordatura|image|principal-voice|accordion-registration|percussion|other-direction |harmony|frame|grouping|print|sound|note|beam|notations|tied|slur|tuplet|glissando|slide|other-notation|ornaments|accidental-mark|technical|articulations|arpeggiate|non-arpeggiate|lyric|figured-bass|credit|credit-image|credit-words|measure"
   >
   <xsl:copy>
      <xsl:if test="not(@id)">
         <xsl:attribute name="id">
            <xsl:value-of select="concat(local-name(),'-',generate-id(.))"/>
         </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>
   </xsl:template>
</xsl:stylesheet>