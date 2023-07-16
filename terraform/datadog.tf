resource "datadog_monitor" "healthcheck" {
  name         = "Servers healthcheck"
  type         = "service check"
  query        = "\"http.can_connect\".over(\"*\").by(\"*\").last(4).count_by_status()"
  message      = ""
  include_tags = false

  monitor_thresholds {
    ok       = 1
    warning  = 2
    critical = 4
  }
}