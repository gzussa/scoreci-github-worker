#!/bin/bash

# The MIT License (MIT)

# Copyright (c) 2016 ScoreCI

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -x

ZONE=us-central1-f
gcloud config set compute/zone $ZONE

GROUP=scoreci-github-worker-group
TEMPLATE=$GROUP-tmpl
SERVICE=scoreci-github-worker

gcloud compute instance-groups managed stop-autoscaling $GROUP --zone $ZONE

gcloud compute forwarding-rules delete $SERVICE-http-rule --global 

gcloud compute target-http-proxies delete $SERVICE-proxy 

gcloud compute url-maps delete $SERVICE-map 

gcloud compute backend-services delete $SERVICE 

gcloud compute http-health-checks delete ah-health-check

gcloud compute instance-groups managed delete $GROUP  

gcloud compute instance-templates delete $TEMPLATE 

gcloud compute firewall-rules delete default-allow-http-8080