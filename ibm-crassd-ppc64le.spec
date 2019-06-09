Name        : ibm-crassd
Version     : 1.0
Release     : 1
Group       : System Environment/Base
BuildArch   : ppc64le
License     : Apache 2.0
Vendor      : IBM
URL         : http://ibm.com
Summary     : IBM POWER LC Cluster RAS Service Package

Requires: java >= 1.7.0
Requires: python34
Requires: python34-requests
Requires: python-configparser
Requires: python34-websocket-client
Requires: libstdc++
Requires: pexpect

%if 0%{?_unitdir:1}
Requires(post): systemd-units
Requires(preun): systemd-units
Requires(postun): systemd-units
%endif

%description
This package is to be applied to service nodes in a POWER 9 LC cluster.  It serv
es to aggregate BMC node data, apply service policy, and forward recommendation 
to cluster service management utilities.  Node data includes hardware machine st
ate including environmental, reliability, service, and failure data.

%post
#!/bin/bash
systemctl daemon-reload 2> /dev/null || true

%files
%defattr(-,root,root,-)
%attr(755,root,root) /opt/ibm/ras/bin/analyzeFQPSPAA0001M.py
%attr(755,root,root) /opt/ibm/ras/bin/analyzeFQPSPPW0034M.py
%attr(755,root,root) /opt/ibm/ras/bin/buildNodeList.py
%config /opt/ibm/ras/bin/config.py
%attr(755,root,root) /opt/ibm/ras/bin/ibm_crassd.py
/opt/ibm/ras/bin/__init__.py
/opt/ibm/ras/bin/notificationlistener.py
/opt/ibm/ras/bin/telemetryServer.py
%attr(755,root,root) /opt/ibm/ras/bin/updateNodeTimes.py
/opt/ibm/ras/bin/plugins/logstash/__init__.py
/opt/ibm/ras/bin/plugins/logstash/logstashnotify.py
/opt/ibm/ras/bin/plugins/ibm_ess/essnotify.py
/opt/ibm/ras/bin/plugins/ibm_ess/__init__.py
/opt/ibm/ras/bin/plugins/__init__.py
/opt/ibm/ras/bin/plugins/ibm_csm/CSMpolicyTable.json
/opt/ibm/ras/bin/plugins/ibm_csm/__init__.py
/opt/ibm/ras/bin/plugins/ibm_csm/csmnotify.py
/opt/ibm/ras/bin/ppc64le/errl
/opt/ibm/ras/lib/crassd.jar
/opt/ibm/ras/etc/ibm-crassd.config
/usr/lib/systemd/system/ibm-crassd.service
/usr/lib/systemd/system-preset/85-ibm-crassd.preset

