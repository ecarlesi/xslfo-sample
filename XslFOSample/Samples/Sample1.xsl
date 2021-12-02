<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="Header.xsl" />

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
        <fo:simple-page-master master-name="simple" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
          <fo:region-body region-name="region-body" margin-top="3cm"/>
          <fo:region-before region-name="region-header" extent="3cm"/>
          <fo:region-after region-name="region-footer" extent="1.5cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="simple">

        <fo:static-content flow-name="region-header">
          <fo:block>
            <xsl:call-template name="custom-header-template" />
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="region-footer">
          <fo:block>
            <fo:inline>FOOTER TEXT</fo:inline>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="region-body">

          <fo:table table-layout="fixed" width="60mm" border-style="solid" start-indent="20mm">
            <fo:table-column column-width="80mm"/>
            <fo:table-column column-width="80mm"/>
            <fo:table-body start-indent="0mm" >

              <xsl:for-each select="/persons/person">
                <fo:table-row>
                  <fo:table-cell border-style="solid">
                    <fo:block>
                      <xsl:value-of select="./firstname"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-style="solid">
                    <fo:block>
                      <xsl:value-of select="./lastname"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>

              </xsl:for-each>

            </fo:table-body>
          </fo:table>

        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
