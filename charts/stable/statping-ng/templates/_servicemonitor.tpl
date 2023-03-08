{{- define "statping.servicemonitor" -}}
{{- if .Values.metrics.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ include "tc.v1.common.lib.chart.names.fullname" . }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
    {{- with .Values.metrics.serviceMonitor.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  selector:
    matchLabels:
      {{- include "tc.common.labels.selectorLabels" . | nindent 6 }}
  endpoints:
    - port: main
      {{- with .Values.metrics.serviceMonitor.interval }}
      interval: {{ . }}
      {{- end }}
      {{- with .Values.metrics.serviceMonitor.scrapeTimeout }}
      scrapeTimeout: {{ . }}
      {{- end }}
      path: /metrics
{{- end }}
{{- end -}}
