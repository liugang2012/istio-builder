
VERSION_LIST="1.14.5  1.11.8  1.15.7  1.16.4"

for VERSION in $VERSION_LIST
do

	subver=`echo $VERSION | awk -F"." '{print $2}' `
	HUB_ARM64="istio"
	if [ $subver -lt 14 ]
	then
		HUB_ARM64=querycapistio
	elif [ $subver -lt 15 ]
	then
		HUB_ARM64=ghcr.io/resf/istio
	fi
	echo "=============  HUB_ARM64=$HUB_ARM64"

	# proxyv2
#	echo "FROM --platform linux/arm64 ${HUB_ARM64}/proxyv2:$VERSION" > proxyv2-$VERSION-arm64
#	echo "FROM --platform linux/amd64 istio/proxyv2:$VERSION" > proxyv2-$VERSION-amd64
	echo "FROM istio/proxyv2:$VERSION" > proxyv2-$VERSION-amd64

	# pilot
#	echo "FROM --platform linux/arm64 ${HUB_ARM64}/pilot:$VERSION" > pilot-$VERSION-arm64
#	echo "FROM --platform linux/amd64 istio/pilot:$VERSION" > pilot-$VERSION-amd64
	echo "FROM istio/pilot:$VERSION" > pilot-$VERSION-amd64

	# operator
#	echo "FROM --platform linux/arm64 ${HUB_ARM64}/operator:$VERSION" > istio-operator-$VERSION-arm64
#	echo "FROM --platform linux/amd64 istio/operator:$VERSION" > istio-operator-$VERSION-amd64
	echo "FROM istio/operator:$VERSION" > istio-operator-$VERSION-amd64

done

l="jaegertracing/jaeger-operator:1.24.0=jaeger-operator-1.24.0
   jaegertracing/jaeger-agent:1.24.0=jaeger-agent-1.24.0
   jaegertracing/all-in-one:1.24.0=jaeger-all-in-one-1.24.0
   jaegertracing/jaeger-collector:1.24.0=jaeger-collector-1.24.0
   jaegertracing/jaeger-ingester:1.24.0=jaeger-ingester-1.24.0
   jaegertracing/jaeger-query:1.24.0=jaeger-query-1.24.0
   grafana/grafana:7.0.5=grafana-7.0.5
   quay.io/kiali/kiali:v1.28=kiali-v1.28
   prom/prometheus:v2.32.1=prometheus-v2.32.1
   docker.io/istio/examples-bookinfo-details-v1:1.17.0=examples-bookinfo-details-v1-1.17.0
   docker.io/istio/examples-bookinfo-ratings-v1:1.17.0=examples-bookinfo-ratings-v1-1.17.0
   docker.io/istio/examples-bookinfo-reviews-v1:1.17.0=examples-bookinfo-reviews-v1-1.17.0
   docker.io/istio/examples-bookinfo-reviews-v2:1.17.0=examples-bookinfo-reviews-v2-1.17.0
   docker.io/istio/examples-bookinfo-reviews-v3:1.17.0=examples-bookinfo-reviews-v3-1.17.0
   docker.io/istio/examples-bookinfo-productpage-v1:1.17.0=examples-bookinfo-productpage-v1-1.17.0
   openservicemesh/tcp-echo-server:latest-main=examples-tcp-echo-server-1.2
   curlimages/curl:7.88.1=examples-curl-7.88.1
   kong/httpbin:0.1.0=examples-httpbin-0.1.0
   gcr.io/spiffe-io/spire-agent:1.2.0=spire-agent:1.2.0
   ghcr.io/spiffe/spiffe-csi-driver:0.1.0=spiffe-csi-driver:0.1.0
   k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.4.0=csi-node-driver-registrar:v2.4.0
   gcr.io/spiffe-io/wait-for-it:latest=wait-for-it:latest
   gcr.io/spiffe-io/spire-server:1.2.0=spire-server:1.2.0
   gcr.io/spiffe-io/k8s-workload-registrar:1.2.0=k8s-workload-registrar:1.2.0"

for i in $l
do
	src=`echo $i | awk -F"=" '{print $1}' `
	dst=`echo $i | awk -F"=" '{print $2}' | sed 's/:/-/g' `
#	echo "FROM --platform linux/arm64 ${src}" > ${dst}-arm64
#	echo "FROM --platform linux/amd64 ${src}" > ${dst}-amd64
	echo "FROM ${src}" > ${dst}-amd64
done
