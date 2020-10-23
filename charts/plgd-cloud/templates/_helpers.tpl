{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "plgd-cloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "plgd-cloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "plgd-cloud.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Create a default fully qualified coap-gateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plgd-cloud.coapgateway.fullname" -}}
{{- if .Values.coapgateway.fullnameOverride -}}
{{- .Values.coapgateway.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.coapgateway.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.coapgateway.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified resource-aggregate name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plgd-cloud.resourceaggregate.fullname" -}}
{{- if .Values.resourceaggregate.fullnameOverride -}}
{{- .Values.resourceaggregate.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.resourceaggregate.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.resourceaggregate.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified resource-directory name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plgd-cloud.resourcedirectory.fullname" -}}
{{- if .Values.resourcedirectory.fullnameOverride -}}
{{- .Values.resourcedirectory.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.resourcedirectory.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.resourcedirectory.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Coap gateway labels
*/}}
{{- define "plgd-cloud.coapgateway.labels" -}}
app: {{ template "plgd-cloud.name" . }}
chart: {{ include "plgd-cloud.chart" . }}
release: "{{ .Release.Name }}"
heritage: "{{ .Release.Service }}"
helm.sh/chart: {{ include "plgd-cloud.chart" . }}
{{ include "plgd-cloud.coapgateway.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.coapgateway.extraLabels }}
{{ toYaml .Values.coapgateway.extraLabels | indent 4 }}
{{- end }}
{{- end -}}

{{/*
Resource aggregate labels
*/}}
{{- define "plgd-cloud.resourceaggregate.labels" -}}
app: {{ template "plgd-cloud.name" . }}
chart: {{ include "plgd-cloud.chart" . }}
release: "{{ .Release.Name }}"
heritage: "{{ .Release.Service }}"
helm.sh/chart: {{ include "plgd-cloud.chart" . }}
{{ include "plgd-cloud.resourceaggregate.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.resourceaggregate.extraLabels }}
{{ toYaml .Values.resourceaggregate.extraLabels | indent 4 }}
{{- end }}
{{- end -}}

{{/*
Resource aggregate labels
*/}}
{{- define "plgd-cloud.resourcedirectory.labels" -}}
app: {{ template "plgd-cloud.name" . }}
chart: {{ include "plgd-cloud.chart" . }}
release: "{{ .Release.Name }}"
heritage: "{{ .Release.Service }}"
helm.sh/chart: {{ include "plgd-cloud.chart" . }}
{{ include "plgd-cloud.resourcedirectory.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.resourcedirectory.extraLabels }}
{{ toYaml .Values.resourcedirectory.extraLabels | indent 4 }}
{{- end }}
{{- end -}}



{{/*
Coap gateway image
*/}}
{{- define "plgd-cloud.coapgateway.image" -}}
    {{- $repositoryName := .Values.global.repository -}}
    {{- $imageName := .Values.coapgateway.image -}}
    {{- $tag := .Chart.AppVersion | toString -}}
    {{- if .Values.global.tag -}}
        {{- $tag = .Values.global.tag | toString -}}
    {{- end -}}
    {{- if .Values.coapgateway.tag -}}
        {{- $tag = .Values.coapgateway.tag | toString -}}
    {{- end -}}
    {{- printf "%s/%s:%s" $repositoryName $imageName $tag -}}
{{- end -}} 


{{/*
Resource aggregate image
*/}}
{{- define "plgd-cloud.resourceaggregate.image" -}}
    {{- $repositoryName := .Values.global.repository -}}
    {{- $imageName := .Values.resourceaggregate.image -}}
    {{- $tag := .Chart.AppVersion | toString -}}
    {{- if .Values.global.tag -}}
        {{- $tag = .Values.global.tag | toString -}}
    {{- end -}}
    {{- if .Values.resourceaggregate.tag -}}
        {{- $tag = .Values.resourceaggregate.tag | toString -}}
    {{- end -}}
    {{- printf "%s/%s:%s" $repositoryName $imageName $tag -}}
{{- end -}} 

{{/*
Resource aggregate image
*/}}
{{- define "plgd-cloud.resourcedirectory.image" -}}
    {{- $repositoryName := .Values.global.repository -}}
    {{- $imageName := .Values.resourcedirectory.image -}}
    {{- $tag := .Chart.AppVersion | toString -}}
    {{- if .Values.global.tag -}}
        {{- $tag = .Values.global.tag | toString -}}
    {{- end -}}
    {{- if .Values.resourcedirectory.tag -}}
        {{- $tag = .Values.resourcedirectory.tag | toString -}}
    {{- end -}}
    {{- printf "%s/%s:%s" $repositoryName $imageName $tag -}}
{{- end -}} 


{{- define "plgd-cloud.labels" -}}
app: {{ template "plgd-cloud.name" . }}
chart: {{ include "plgd-cloud.chart" . }}
release: "{{ .Release.Name }}"
heritage: "{{ .Release.Service }}"
helm.sh/chart: {{ include "plgd-cloud.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.extraLabels }}
{{ toYaml .Values.extraLabels | indent 4 }}
{{- end }}
{{- end -}}

{{/*
Coap gateway selector lagels
*/}}
{{- define "plgd-cloud.coapgateway.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.coapgateway.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of:  {{ include "plgd-cloud.name" . }}
{{- end -}}

{{/*
Resource aggregate selector lagels
*/}}
{{- define "plgd-cloud.resourceaggregate.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.resourceaggregate.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of:  {{ include "plgd-cloud.name" . }}
{{- end -}}

{{/*
Resource aggregate selector lagels
*/}}
{{- define "plgd-cloud.resourcedirectory.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.resourcedirectory.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of:  {{ include "plgd-cloud.name" . }}
{{- end -}}

{{/*
Authorization server service address
*/}}
{{- define "plgd-cloud.authorizationserver.address" -}}
    {{ $dnsName := include "plgd-cloud.authorizationserver.dns" . }}
    {{- $servicePort := .Values.authorizationserver.grpcPort | toString -}}
    {{- printf "%s:%s" $dnsName $servicePort -}}
{{- end -}}

{{- define "plgd-cloud.authorizationserver.dns" -}}
    {{- if .Values.authorizationserver.address -}}
        {{- printf "%s" .Values.authorizationserver.address -}}
    {{- else -}}
        {{- $serviceName := .Values.authorizationserver.name -}}
        {{- $namespaceName := .Release.Namespace -}}
        {{- $clusterName := .Values.global.clusterDomain -}}
        {{- printf "%s.%s.svc.%s" $serviceName $namespaceName .Values.global.clusterDomain -}}
    {{- end -}}
{{- end -}}

{{- define "plgd-cloud.resourcedirectory.address" -}}
    {{ $dnsName := include "plgd-cloud.resourcedirectory.dns" . }}
    {{- $servicePort := .Values.resourcedirectory.grpcPort | toString -}}
    {{- printf "%s:%s" $dnsName $servicePort -}}
{{- end -}}

{{- define "plgd-cloud.resourcedirectory.dns" -}}
    {{- if .Values.resourcedirectory.address -}}
        {{- printf "%s" .Values.resourcedirectory.address -}}
    {{- else -}}
        {{- $serviceName := include "plgd-cloud.resourcedirectory.fullname" . -}}
        {{- $namespaceName := .Release.Namespace -}}
        {{- $clusterName := .Values.global.clusterDomain -}}
        {{- printf "%s.%s.svc.%s" $serviceName $namespaceName .Values.global.clusterDomain -}}
    {{- end -}}
{{- end -}}

{{- define "plgd-cloud.resourceaggregate.address" -}}
    {{ $dnsName := include "plgd-cloud.resourceaggregate.dns" . }}
    {{- $servicePort := .Values.resourceaggregate.grpcPort | toString -}}
    {{- printf "%s:%s" $dnsName $servicePort -}}
{{- end -}}

{{- define "plgd-cloud.resourceaggregate.dns" -}}
    {{- if .Values.resourceaggregate.address -}}
        {{- printf "%s" .Values.resourceaggregate.address -}}
    {{- else -}}
        {{- $serviceName := include "plgd-cloud.resourceaggregate.fullname" . -}}
        {{- $namespaceName := .Release.Namespace -}}
        {{- $clusterName := .Values.global.clusterDomain -}}
        {{- printf "%s.%s.svc.%s" $serviceName $namespaceName .Values.global.clusterDomain -}}
    {{- end -}}
{{- end -}}

{{- define "plgd-cloud.mongodb.connectionString" -}}
{{- printf "mongodb://%s%s" .Values.mongodb.address .Values.mongodb.connectionUriParam -}}
{{- end -}}

{{- define "plgd-cloud.nats.connectionString" -}}
    {{- printf "nats://%s" .Values.nats.address }}
{{- end -}}


{{- define "plgd-cloud.resourcedirectory.listenCrtName" -}}
  {{- if .Values.resourcedirectory.tls.listen.secret.name }}
       {{- printf "%s" .Values.resourcedirectory.tls.listen.secret.name -}}
  {{- else }}
      {{- $fullName := include "plgd-cloud.resourcedirectory.fullname" . -}}
      {{- printf "%s-listen-crt" $fullName -}}
  {{- end }}
{{- end }}

{{- define "plgd-cloud.resourceaggregate.listenCrtName" -}}
  {{- if .Values.resourceaggregate.tls.listen.secret.name }}
       {{- printf "%s" .Values.resourceaggregate.tls.listen.secret.name -}}
  {{- else }}
      {{- $fullName := include "plgd-cloud.resourceaggregate.fullname" . -}}
      {{- printf "%s-listen-crt" $fullName -}}
  {{- end }}
{{- end }}

{{- define "plgd-cloud.coapgateway.listenCrtName" -}}
  {{- if .Values.coapgateway.tls.listen.secret.name }}
       {{- printf "%s" .Values.coapgateway.tls.listen.secret.name -}}
  {{- else }}
      {{- $fullName := include "plgd-cloud.coapgateway.fullname" . -}}
      {{- printf "%s-listen-crt" $fullName -}}
  {{- end }}
{{- end }}

{{- define "plgd-cloud.dialCrtName" -}}
  {{- if .Values.global.security.certManager.tls.dial.secret.name }}
       {{- printf "%s" .Values.global.security.certManager.tls.dial.secret.name -}}
  {{- else }}
      {{- $fullName := include "plgd-cloud.fullname" . -}}
      {{- printf "%s-dial-crt" $fullName -}}
  {{- end }}
{{- end }}

{{- define "plgd-cloud.clientAuthCfg" -}}
  {{- $fullName := include "plgd-cloud.fullname" . -}}
  {{- printf "%s-auth-client-cfg" $fullName -}}
{{- end }}

{{- define "plgd-cloud.wellKnownCfg" -}}
  {{- $fullName := include "plgd-cloud.fullname" . -}}
  {{- printf "%s-well-known-cfg" $fullName -}}
{{- end }}


