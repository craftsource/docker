#!/usr/bin/env bash
# MIT License

# Copyright (c) 2019 Todd Jason Lehn

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

# assume_role assumes an AWS IAM role defined by the AWS_ROLE_ARN value. If
# successful, the assumed role credentials are set via the AWS_ACCESS_KEY_ID,
# AWS_SECRET_ACCESS_KEY and AWS_SESSION_TOKEN environment variables.
# clear_credentials should be called once the assumed role is no longer needed
# to prevent credentials being leaked across execution contexts.
function assume_role(){
    unset AWS_SESSION_TOKEN
    output=$(aws sts assume-role \
                    --role-arn "${AWS_ROLE_ARN}" \
                    --role-session-name "awsenv")

    export AWS_ACCESS_KEY_ID=$(echo $output | jq .Credentials.AccessKeyId | xargs)
    export AWS_SECRET_ACCESS_KEY=$(echo $output | jq .Credentials.SecretAccessKey | xargs)
    export AWS_SESSION_TOKEN=$(echo $output | jq .Credentials.SessionToken | xargs)
}

# clear_credentials clears the AWS_ environment variables that reference AWS
# credentials.
function clear_credentials(){
    unset AWS_ROLE_ARN
    unset AWS_SESSION_TOKEN
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
}