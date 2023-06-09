package http

#MetricsConfig: {
	metrics_port?:                               int32
	metrics_host?:                               string
	metrics_dashboard_uri_path?:                 string
	metrics_prometheus_uri_path?:                string
	prometheus_system_metrics_interval_seconds?: int32
	metrics_ring_buffer_size?:                   int32
	metrics_key_function?:                       string
	metrics_key_depth?:                          string
	throughput_timeout_duration?:                string
	use_metrics_tls?:                            bool
	server_ca_cert_path?:                        string
	server_cert_path?:                           string
	server_key_path?:                            string
	enable_cloudwatch?:                          bool
	cw_namespace?:                               string
	cw_dimensions?:                              string
	cw_metrics_routes?:                          string
	cw_metrics_values?:                          string
	cw_debug?:                                   bool
	cw_reporting_interval_seconds?:              int32
	aws_region?:                                 string
	aws_access_key_id?:                          string
	aws_secret_access_key?:                      string
	aws_session_token?:                          string
	aws_profile?:                                string
	aws_config_file?:                            string
	metrics_receiver?:                           #MetricsConfig_MetricsReceiver
	shadow_clusters?: [...string]
}

#MetricsRouteConfig: {
	metrics_key_function?: string
	metrics_key_depth?:    string
}

#MetricsConfig_MetricsReceiver: {
	redis_connection_string?: string
	nats_connection_string?:  string
	push_interval_seconds?:   int32
}
