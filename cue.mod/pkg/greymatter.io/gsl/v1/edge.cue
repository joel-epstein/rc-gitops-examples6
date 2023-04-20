package v1

// Edges are services with an empty default route/cluster to get them
// showing up green on the dashboard in 1.x
#Edge: edge = {
	#Service

	// Edges don't have documentation so we 
	// don't allow routing to docs.
	api_endpoint:      "N/A"
	api_spec_endpoint: "N/A"

	// We create a dangling cluster for edge to show up green
	// in the greymatter dashboard.
	raw_upstreams: {
		(edge.name): {
			#Upstream
			namespace: edge.context.globals.namespace
		}
	}
}
