import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class CdkAppSampleStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here
    // it can be improved by extracting methods and constructs accordingly
    // also, some input parameters can be added by extending props?: cdk.StackProps (introduce an interface accordingly)

    const s3Bucket = new cdk.aws_s3.Bucket(this, 'DemoWebBucket');
    const cloudFrontOAC = new cdk.aws_cloudfront.CfnOriginAccessControl(this, 'CloudFrontWebOAC', {
      originAccessControlConfig: {
        name: 'DemoCloudFrontWebOAC',
        description: 'Origin Access Control to access assets in S3 bucket',
        signingBehavior: 'no-override',
        signingProtocol: 'sigv4',
        originAccessControlOriginType: 's3'
      }
    });
    const cloudFrontWebDistribution = new cdk.aws_cloudfront.Distribution(this, 'DemoCloudFrontWebDistribution', {
      defaultBehavior: {
        origin: new cdk.aws_cloudfront_origins.S3Origin(s3Bucket),
        viewerProtocolPolicy: cdk.aws_cloudfront.ViewerProtocolPolicy.HTTPS_ONLY,
        allowedMethods: cdk.aws_cloudfront.AllowedMethods.ALLOW_GET_HEAD,
      },
      enabled: true,
      comment: 'CloudFront Web distribution for demo stack',
      enableIpv6: true,
      defaultRootObject: 'index.html',
      httpVersion: cdk.aws_cloudfront.HttpVersion.HTTP2_AND_3,
      minimumProtocolVersion: cdk.aws_cloudfront.SecurityPolicyProtocol.TLS_V1_2_2021
    });

    /*
      The following code is needed to set up Origin Access Control
      Now cdk does not support OAC for Distribution
      @link https://github.com/aws/aws-cdk/issues/21771
      This is a temporary solution until AWS CDK gets native support of OAC for Distribution
      @link https://github.com/aws/aws-cdk-rfcs/issues/491
     */

    const cfnDistribution = cloudFrontWebDistribution.node.defaultChild as cdk.aws_cloudfront.CfnDistribution
    cfnDistribution.addOverride('Properties.DistributionConfig.Origins.0.S3OriginConfig.OriginAccessIdentity', '')
    cfnDistribution.addPropertyOverride('DistributionConfig.Origins.0.OriginAccessControlId', cloudFrontOAC.getAtt('Id'))

    const comS3PolicyOverride = s3Bucket.node.findChild('Policy').node.defaultChild as cdk.aws_s3.CfnBucketPolicy;
    const statement = comS3PolicyOverride.policyDocument.statements[ 0 ];

    if(statement[ '_principal' ] && statement[ '_principal' ].CanonicalUser){
      delete statement[ '_principal' ].CanonicalUser
    }

    comS3PolicyOverride.addOverride('Properties.PolicyDocument.Statement.0.Principal', { 'Service': 'cloudfront.amazonaws.com' });
    comS3PolicyOverride.addOverride('Properties.PolicyDocument.Statement.0.Condition',
      {
        'StringEquals': {
          'AWS:SourceArn': this.formatArn({
            service: 'cloudfront',
            region: '',
            resource: 'distribution',
            resourceName: cloudFrontWebDistribution.distributionId,
            arnFormat: cdk.ArnFormat.SLASH_RESOURCE_NAME
          })
        }
      }
    );
    const s3OriginNode = cloudFrontWebDistribution.node
      .findAll()
      .filter((child) => child.node.id === 'S3Origin');
    s3OriginNode[ 0 ].node.tryRemoveChild('Resource');
  }
}
