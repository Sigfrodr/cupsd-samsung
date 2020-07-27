FROM olbat/cupsd

RUN cd /tmp/ && wget http://downloadcenter.samsung.com/content/DR/201704/20170407143829533/uld_V1.00.39_01.17.tar.gz
RUN cd /tmp/ && tar -xvzf uld_V1.00.39_01.17.tar.gz
RUN cp /tmp/uld/x86_64/libscmssc.so /usr/lib
RUN cp /tmp/uld/x86_64/smfpnetdiscovery /usr/lib/cups/backend
RUN cp /tmp/uld/x86_64/pstosecps /usr/lib/cups/filter
RUN cp /tmp/uld/x86_64/rastertospl /usr/lib/cups/filter
RUN ln -s rastertospl /usr/lib/cups/filter/rastertosplc
RUN mkdir -p /usr/share/cups/model/suld
RUN for ppd in /tmp/uld/noarch/share/ppd/*.ppd; do gzip < "$ppd" > /usr/share/cups/model/suld/"${ppd##*/}".gz; done
RUN mkdir -p /usr/share/cups/model/suld/cms
RUN for cts in /tmp/uld/noarch/share/ppd/cms/*.cts; do cp "$cts" /usr/share/cups/model/suld/cms; done
RUN cd /tmp/ && wget https://www.bchemnet.com/suldr/driver/UnifiedLinuxDriver-1.00.06.tar.gz
RUN mv /tmp/uld /tmp/uld2
RUN cd /tmp/ && tar -xvzf UnifiedLinuxDriver-1.00.06.tar.gz
RUN cp /tmp/uld/x86_64/pstospl /usr/lib/cups/filter
RUN cp /tmp/uld/x86_64/pstosplc /usr/lib/cups/filter
