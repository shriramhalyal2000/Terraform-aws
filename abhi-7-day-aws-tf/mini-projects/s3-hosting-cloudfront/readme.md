The is a poc integrating AWS cloud servuce Cloud front with S3 bucket for static website hosting
1. Create a Cloud front distribution, select region and availability zones. 
   create origin access control for cloudfront, and handle cloudfront distribution caching, ttl, certificate issue , methods for fetching object from bucket.
   configure TTL for cached websites on distributions for user to access.
2. Create a s3 bucket and add objets to be acced by clud front and requested by user.
   configure object access policies for access, and host static website from bucket.
   allow cloudfront to access bucket resource with get and list objects methods. 