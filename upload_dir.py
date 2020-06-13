import boto
import boto.s3

import os.path
import sys

# Fill these in - you get them when you sign up for S3
AWS_ACCESS_KEY_ID = '*********Your Access Key***********'
AWS_ACCESS_KEY_SECRET = '*******************Your Secret key*************'
# Fill in info on data to upload
# destination bucket name
bucket_name = '******BUCKET********'
# source directory
sourceDir = '********Path on your local machine*********'
# destination directory name (on s3)
destDir = '*******Destination directory in your bucket******'

#max size in bytes before uploading in parts. between 1 and 5 GB recommended
MAX_SIZE = 20 * 1000 * 1000
#size of parts when uploading in parts
PART_SIZE = 6 * 1000 * 1000

conn = boto.connect_s3(AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET)

bucket = conn.get_bucket(bucket_name)

uploadFileNames = []
for (sourceDir, dirname, filename) in os.walk(sourceDir):
    uploadFileNames.extend(filename)
    break

def percent_cb(complete, total):
    sys.stdout.write('.')
    sys.stdout.flush()

for filename in uploadFileNames:
    sourcepath = os.path.join(sourceDir + '/' + filename)
    destpath = os.path.join(destDir, filename)
    print ('Uploading %s to Amazon S3 bucket %s' % \
        (sourcepath, bucket_name))

    filesize = os.path.getsize(sourcepath)
    if filesize > MAX_SIZE:
        print ("multipart upload")
        mp = bucket.initiate_multipart_upload(destpath)
        fp = open(sourcepath,'rb')
        fp_num = 0
        while (fp.tell() < filesize):
            fp_num += 1
            print ("uploading part %i" %fp_num)
            mp.upload_part_from_file(fp, fp_num, cb=percent_cb, num_cb=10, size=PART_SIZE)

        mp.complete_upload()

    else:
        print ("singlepart upload")
        k = boto.s3.key.Key(bucket)
        k.key = destpath
        k.set_contents_from_filename(sourcepath,
                cb=percent_cb, num_cb=10)
