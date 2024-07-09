import {
  GetObjectCommand,
  PutObjectCommand,
  S3Client,
} from "@aws-sdk/client-s3";
import sharp from "sharp";
import "dotenv/config";
import { Readable } from "stream";

const s3 = new S3Client({ region: process.env.AWS_REGION });
export const handler = async (event, context) => {
  const srcBucket = event.Records[0].s3.bucket.name;
  const srcKey = decodeURIComponent(
    event.Records[0].s3.object.key.replace(/\+/g, " ")
  );

  const dstBucket = process.env.S3_RESIZED_BUCKET_NAME;
  const dstKey = "resized-" + srcKey;
  let content_buffer;
  try {
    const params = {
      Bucket: srcBucket,
      Key: srcKey,
    };
    const res = await s3.send(new GetObjectCommand(params));
    const stream = res.Body;

    if (stream instanceof Readable) {
      content_buffer = Buffer.concat(await stream.toArray());
    } else {
      throw new Error("Unknown object stream type");
    }
  } catch (error) {
    console.log("ERROR<<<< " + error);
    return;
  }

  let output_buffer;
  try {
    const image = sharp(content_buffer, { limitInputPixels: false });
    const metadata = await image.metadata();
    const originalWidth = metadata.width;
    const originalHeight = metadata.height;

    let width = originalWidth >= 400 ? 400 : originalWidth;
    let height = originalHeight >= 400 ? 400 : originalHeight;
    output_buffer = await image.resize(width, height).toBuffer();
  } catch (error) {
    console.log("ERROR<<<< " + error);
    return;
  }

  try {
    const dstParams = {
      Bucket: dstBucket,
      Key: dstKey,
      Body: output_buffer,
      ContentType: "image",
      ACL: 'public-read'
    };
    await s3.send(new PutObjectCommand(dstParams));
  } catch (error) {
    console.log("ERROR<<<< " + error);
    return;
  }
  console.log(
    "Successfull resized" +
      srcBucket +
      "/" +
      srcKey +
      " and uploaded to " +
      dstBucket +
      "/" +
      dstKey
  );
};
