{{/* vim: set filetype=mustache: */}}

{{/* Provides common labels */}}
{{- define "waylon.commonLabels" -}}
app.kubernetes.io/part-of: {{ .Chart.Name }}
helm.sh/chart: {{ .Chart.Name }}
{{- end -}}
