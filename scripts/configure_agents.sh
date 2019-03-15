#    bash 'Configuring Replication Agents' do
CURL_RETRY_NUM="2"
AEM_ADMIN_PASSWORD="admin"
CQ_PORT="4502"
declare -a arr="${pubpriv_ips}"

for i in "${arr[@]}"
do
   # or do whatever with individual element of the array
done

agent_name="$i"
agent_front_fqdn="${site_dnsname}"
agent_title="Publisher ${site_dnsname}"

CURL="curl --retry ${CURL_RETRY_NUM} -s -# -u admin:${AEM_ADMIN_PASSWORD}"

$CURL --data jcr:primaryType=cq:Page http://localhost:${CQ_PORT}/etc/replication/agents.author/${agent_name} | grep -E 'id="Status|Message".*200|OK'

$CURL -X POST \
	--data-urlencode "./sling:resourceType=cq/replication/components/agent" \
	--data-urlencode "./jcr:lastModified=" \
	--data-urlencode "./jcr:lastModifiedBy=" \
	--data-urlencode "_charset_=utf-8" \
	--data-urlencode ":status=browser" \
	--data-urlencode "./jcr:title=${agent_title}" \
	--data-urlencode "./jcr:description=Agent that replicates to the ${agent_title} instance." \
	--data-urlencode "./enabled=true" \
	--data-urlencode "./enabled@Delete=" \
	--data-urlencode "./serializationType=durbo" \
	--data-urlencode "./retryDelay=60000" \
	--data-urlencode "./userId=" \
	--data-urlencode "./logLevel=info" \
	--data-urlencode "./reverseReplication@Delete=" \
	--data-urlencode "./transportUri=http://$i:4503/bin/receive?sling:authRequestLogin=1" \
	--data-urlencode "./transportUser=admin" \
	--data-urlencode "./transportPassword=${AEM_ADMIN_PASSWORD}" \
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
	http://localhost:${CQ_PORT}/etc/replication/agents.author/${agent_name}/jcr:content | grep -E 'id="Status|Message".*200|OK'

#  node[:aem][:flushnodes].to_enum.with_index(1).each do |ip, count|
    server = "#{ip}"
    host = "flush#{count}"
    hostsfile_entry "#{server}" do
      hostname  "#{host}"
      action    :create_if_missing
    end
    hostsfile_entry "#{server}" do
      hostname  "#{host}"
      comment   'Updated by Chef'
      action    :append
    end
    bash 'Configuring Flush Agents' do
      code <<-EOH
      CURL_RETRY_NUM="2"
      AEM_ADMIN_PASSWORD="#{node[:aem][:adminpass]}"
      CQ_PORT="#{node[:aem][:authorport]}"

      agent_name="#{host}"
      agent_front_fqdn="#{host}"
      agent_title="Flush ${agent_front_fqdn}"
      agent_front_port=80

      CURL="curl --retry ${CURL_RETRY_NUM} -s -# -u admin:${AEM_ADMIN_PASSWORD}"

      $CURL --data jcr:primaryType=cq:Page http://localhost:${CQ_PORT}/etc/replication/agents.author/${agent_name} | grep -E 'id="Status|Message".*200|OK'

      $CURL -X POST \
      	--data-urlencode "./sling:resourceType=cq/replication/components/agent" \
      	--data-urlencode "./jcr:lastModified=" \
      	--data-urlencode "./jcr:lastModifiedBy=" \
      	--data-urlencode "_charset_=utf-8" \
      	--data-urlencode ":status=browser" \
      	--data-urlencode "./jcr:title=${agent_title}" \
      	--data-urlencode "./jcr:description=Agent that sends flush requests to the dispatcher." \
      	--data-urlencode "./enabled=true" \
      	--data-urlencode "./enabled@Delete=" \
      	--data-urlencode "./serializationType=flush" \
      	--data-urlencode "./retryDelay=60000" \
      	--data-urlencode "./userId=" \
      	--data-urlencode "./logLevel=error" \
      	--data-urlencode "./reverseReplication@Delete=" \
      	--data-urlencode "./transportUri=http://${agent_front_fqdn}:${agent_front_port}/dispatcher/invalidate.cache" \
      	--data-urlencode "./transportUser=" \
      	--data-urlencode "./transportPassword=" \
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
      	http://localhost:${CQ_PORT}/etc/replication/agents.author/${agent_name}/jcr:content | grep -E 'id="Status|Message".*200|OK'
      EOH
    end
  end
#  bash 'Disable Default Agents' do
    code <<-EOH
    CURL_RETRY_NUM="2"
    AEM_ADMIN_PASSWORD="#{node[:aem][:adminpass]}"
    CQ_PORT="#{node[:aem][:authorport]}"

    agent_name="flush"
    agent_title="Flush ${agent_front_fqdn}"
    agent_front_port=80

    CURL="curl --retry ${CURL_RETRY_NUM} -s -# -u admin:${AEM_ADMIN_PASSWORD}"

    $CURL -X POST \
    	--data-urlencode "./sling:resourceType=cq/replication/components/agent" \
    	--data-urlencode "./jcr:lastModified=" \
    	--data-urlencode "./jcr:lastModifiedBy=" \
    	--data-urlencode "_charset_=utf-8" \
    	--data-urlencode ":status=browser" \
    	--data-urlencode "./jcr:title=Agent Publish" \
    	--data-urlencode "./jcr:description=Agent that replicates to the default publish instance." \
    	--data-urlencode "./enabled@Delete=" \
    	--data-urlencode "./serializationType=durbo" \
    	--data-urlencode "./retryDelay=60000" \
    	--data-urlencode "./userId=" \
    	--data-urlencode "./logLevel=info" \
    	--data-urlencode "./reverseReplication@Delete=" \
    	--data-urlencode "./transportUri=http://localhost:4503/bin/receive?sling:authRequestLogin=1" \
    	--data-urlencode "./transportUser=admin" \
    	--data-urlencode "./transportPassword={2fe3a1bc231e172fce538a46c4eec7153f48c4c4266191643a634e41dd1b2543}" \
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
    	http://localhost:${CQ_PORT}/etc/replication/agents.author/publish/jcr:content | grep -E 'id="Status|Message".*200|OK'

    $CURL -X POST \
    	--data-urlencode "./sling:resourceType=cq/replication/components/agent" \
    	--data-urlencode "./jcr:lastModified=" \
    	--data-urlencode "./jcr:lastModifiedBy=" \
    	--data-urlencode "_charset_=utf-8" \
    	--data-urlencode ":status=browser" \
    	--data-urlencode "./jcr:title=Agent Flush" \
    	--data-urlencode "./jcr:description=Agent that sends flush requests to the dispatcher." \
    	--data-urlencode "./enabled@Delete=" \
    	--data-urlencode "./serializationType=flush" \
    	--data-urlencode "./retryDelay=60000" \
    	--data-urlencode "./userId=" \
    	--data-urlencode "./logLevel=error" \
    	--data-urlencode "./reverseReplication@Delete=" \
    	--data-urlencode "./transportUri=http://localhost:${agent_front_port}/dispatcher/invalidate.cache" \
    	--data-urlencode "./transportUser=" \
    	--data-urlencode "./transportPassword=" \
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
    	http://localhost:${CQ_PORT}/etc/replication/agents.author/flush/jcr:content | grep -E 'id="Status|Message".*200|OK'
    EOH
  end
else
  puts "No Agents to install. If you do have them, configure node[:aem][:confagents] to true"
end
