<template>
  <q-page-container>

    <div class="q-pa-md" style="max-width: 300px">
        <h5>S3 파일 리스트</h5>
        <div v-for="(file, index) in fileList" :key="file.Key">
          #{{index + 1}} #{{file.Key}}
        </div>
        <h5>S3 파일 업로더</h5>
        <input id="file-selector" ref="file" type="file" @change="handlerFileUpload()">
        <q-btn @click="uploadFile" color="primary" flat>업로드</q-btn>
    </div>
  </q-page-container>
</template>

<script>
import AWS from 'aws-sdk'
import { defineComponent, ref, onMounted, nextTick } from 'vue'
import { useRoute } from 'vue-router'


const route = useRoute()
export default {
  setup () {
    return {
      model: ref(null)
    }
  },
  data () {
    return {
      file: null,
      bucketName: process.env.AWSBucket,
      bucketRegion: process.env.AWSRegion,
      IdentityPoolId: process.env.AWSIdentityPoolId,
      fileList: [],
    }
  },
  created() {
    this.getFiles()
  },
  methods: {
    handlerFileUpload() {
      this.file = this.$refs.file.files[0]
      console.log(this.file, '파일 업로드 완료.')
    },
    uploadFile() {
      AWS.config.update({
        region: this.bucketRegion,
        credentials: new AWS.CognitoIdentityCredentials({
          IdentityPoolId: this.IdentityPoolId
        })
      });

      const s3 = new AWS.S3({
        apiVersion: '2006-03-01',
        params: {
          Bucket: this.bucketName
        }
      });

      let fileKey = this.file.name
      s3.upload({
        Key: fileKey,
        Body: this.file,
        ACL: 'public-read'
      }, (err, data) => {
        if (err) {
          console.log(err)
          return alert('파일 전송 실패: '+err.message);
        }
        alert('파일 전송 성공');
        this.getFiles()
        console.log(data)
      });
    },
    getFiles() {
      AWS.config.update({
        region: this.bucketRegion,
        credentials: new AWS.CognitoIdentityCredentials({
          IdentityPoolId: this.IdentityPoolId
        })
      });

      const s3 = new AWS.S3({
        apiVersion: '2006-03-01',
        params: {
          Bucket: this.bucketName
        }
      });

      s3.listObjects({
        Delimiter: '/'
      }, (err, data) => {
        if (err) {
          console.log(err)
          return alert('파일 리스트 불러오기 실패: '+err.message);
        }
        this.fileList = data.Contents
        // alert('파일 리스트 불러오기 성공');
        console.log(data)
      });
    }
  }

}
</script>
