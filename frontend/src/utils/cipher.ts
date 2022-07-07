import Encrypt from 'assets/libs/Encrypt'

class cipher {
  private keys: string | null
  constructor() {}
  setKeys(keys: string) {
    this.keys = keys
  }
  enc(text: string): any {
    let data: any = text
    if (this.keys != null) {
      const encrypt = new Encrypt(this.keys, text)
      data = Object.assign({ key: encrypt.rsakey, value: encrypt.data_base64() })
    }
    return data
  }
}

export default cipher
