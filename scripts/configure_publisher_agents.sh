#!/bin/bash -x
CURL_RETRY_NUM="2"
AEM_ADMIN_PASSWORD="admin"
agent="Publisher"
CQ_PORT="4502"
sitename=${site_dnsname}
AUTHORIP="localhost"
IPS=${pubpriv_ips}
TEMPNUM=0

for i in $(echo $IPS | sed "s/,/ /g")
do
	((TEMPNUM=TEMPNUM+1))
	agent_name="Rep0$TEMPNUM"
	agent_front_fqdn="$sitename"
	agent_title="$agent $agent_name"

	CURL="curl --retry $CURL_RETRY_NUM -s -# -u admin:$AEM_ADMIN_PASSWORD"

	$CURL --data jcr:primaryType=cq:Page http://$AUTHORIP:$CQ_PORT/etc/replication/agents.author/$agent_name | grep -E 'id="Status|Message".*200|OK'

	$CURL -X POST \
	--data-urlencode "./sling:resourceType=cq/replication/components/agent" \
	--data-urlencode "./jcr:lastModified=" \
	--data-urlencode "./jcr:lastModifiedBy=" \
	--data-urlencode "_charset_=utf-8" \
	--data-urlencode ":status=browser" \
	--data-urlencode "./jcr:title=$agent_name" \
	--data-urlencode "./jcr:description=Agent that replicates to the $agent_title instance." \
	--data-urlencode "./enabled=true" \
	--data-urlencode "./enabled@Delete=" \
	--data-urlencode "./serializationType=durbo" \
	--data-urlencode "./retryDelay=60000" \
	--data-urlencode "./userId=" \
	--data-urlencode "./logLevel=info" \
	--data-urlencode "./reverseReplication@Delete=" \
	--data-urlencode "./transportUri=http://$i:4503/bin/receive?sling:authRequestLogin=1" \
	--data-urlencode "./transportUser=admin" \
	--data-urlencode "./transportPassword=$AEM_ADMIN_PASSWORD" \
	--data-urlencode "./transportNTLMDomain=" \
	--data-urlencode "./transportNTLMHost=" \
	--data-urlencode "./ssl=" \
	--data-urlencode "./protocolHTTPExpired@Delete=" \
	--data-urlencode "./proxyHost=" \
	--data-urlencode "./proxyPort=" \
	--data-urlencode "./proxyUser=" \
	--data-urlencode "./proxyPassword=" \
	--data-urlencode "./proxyNTLMDomain=" \
	--data-urlencode "./proxyNTLMHost=" \
	--data-urlencode "./protocolInterface=" \
	--data-urlencode "./protocolHTTPMethod=" \
	--data-urlencode "./protocolHTTPHeaders@Delete=" \
	--data-urlencode "./protocolHTTPConnectionClose@Delete=true" \
	--data-urlencode "./protocolConnectTimeout=" \
	--data-urlencode "./protocolSocketTimeout=" \
	--data-urlencode "./protocolVersion=" \
	--data-urlencode "./triggerSpecific@Delete=" \
	--data-urlencode "./triggerModified@Delete=" \
	--data-urlencode "./triggerDistribute@Delete=" \
	--data-urlencode "./triggerOnOffTime@Delete=" \
	--data-urlencode "./triggerReceive@Delete=" \
	--data-urlencode "./noStatusUpdate@Delete=" \
	--data-urlencode "./noVersioning@Delete=" \
	--data-urlencode "./queueBatchMode@Delete=" \
	--data-urlencode "./queueBatchWaitTime=" \
	--data-urlencode "./queueBatchMaxSize=" \
	http://$AUTHORIP:$CQ_PORT/etc/replication/agents.author/$agent_name/jcr:content | grep -E 'id="Status|Message".*200|OK'
done

curl -u admin:$AEM_ADMIN_PASSWORD -F "jcr:primaryType=sling:OsgiConfig" -F "alias=/crx/server" -F "dav.create-absolute-uri=true" -F "dav.create-absolute-uri@TypeHint=Boolean" http://localhost:4502/apps/system/config/org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet
