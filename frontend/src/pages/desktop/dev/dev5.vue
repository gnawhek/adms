<template>
  <div class="q-pa-md" style="max-width: 300px">
    <h5>S3 파일 리스트</h5>
    <div v-for="(file, index) in fileList" :key="file.Key">
      #{{index + 1}} #{{file.Key}}
    </div>
    파일 등록하기
    <input id="file-selector" ref="file" type="file" @change="handlerFileUpload()">
<!--    <q-file v-model="model" label="Standard" ref="file" @change="selectFile" />-->
    <q-btn @click="submit" color="primary" flat>업로드</q-btn>
  </div>
</template>

<script>
import AWS from 'aws-sdk'
import { uploadFormData } from "src/api/file-api";
import { ref } from 'vue';

export default {
  setup () {
    return {
      model: ref(null)
    }
  },
  data() {
    return {
      file: "test file",
      bucketName: process.env.AWSBucket,
      bucketRegion: process.env.AWSRegion,
      IdentityPoolId: process.env.AWSIdentityPoolId,
      fileList: [],
    };
  },
  created() {
    this.getFiles()
  },
  methods: {
    async submit() {
      const formData = new FormData();
      // formData.append("user", this.file);
      formData.append("file", this.file);

      try {
        const { data } = await uploadFormData(formData);
        console.log(data);
      } catch (err) {
        console.log(err);
      }
    },
    handlerFileUpload() {
      this.file = this.$refs.file.files[0]
      console.log(this.file, '파일 업로드 완료.')
    },
    /*selectFile(file) {
      this.file = file;
    },*/
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
  },
};
</script>
