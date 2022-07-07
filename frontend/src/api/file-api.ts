import http from './http'
import { useAuthStore } from 'src/store/auth'
import { ResultData, User } from 'src/types'
import axios from "axios";
import Encrypt from 'assets/libs/Encrypt'

/**
 * 파일업로드 FormData 사용
 * @param formData
 */
export async function uploadFormData(formData: FormData) {
	const response = await axios.post(
    process.env.VUE_APP_API + '/uploadFileS3',
    formData,
    {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });
  return response
}
