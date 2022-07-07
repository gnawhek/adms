import Encrypt from 'assets/libs/Encrypt'
import { defineAsyncComponent } from 'vue'
import cipher from 'src/utils/cipher'

// const tools = {
//   a: rgbToHex({r: 255, g:255, b:0})
// };

class tools {
  private static _cipher: cipher
  static get cipher(): cipher {
    if (tools._cipher == null) {
      tools._cipher = new cipher()
    }
    return tools._cipher
  }

  static toEncrypt(data: string): string {
    const encrypt = new Encrypt(null, data)
    const encryptText = encrypt.key + encrypt.data
    return encryptText
  }

  static toDecrypt(encryptData: string): any | null {
    if (encryptData == null) {
      return null
    }

    const encrypt = new Encrypt(null, null)
    const key = encryptData.substring(0, 16)
    const encryptText = encryptData.substring(16, encryptData.length)
    const decrypt = encrypt.decrypt(encryptText, key)

    return JSON.parse(decrypt)
  }

  static testEncryptToDecrypt() {
    const data = {
      username: 'username',
      password: 'password',
    }
    const encrypt = new Encrypt(null, JSON.stringify(data))
    const encryptText = encrypt.key + encrypt.data
    const key = encryptText.substring(0, 16)
    const decryptText = encrypt.decrypt(encryptText.substring(16, encryptText.length), key)
    console.log(decryptText)
  }

  static wait = (timeToDelay: number) => new Promise((resolve) => setTimeout(resolve, timeToDelay))

  static componentsToImportVue = (component: string) => defineAsyncComponent(() => tools.importVue(component))

  static menuToComponent = (component: string, devMode = false) => defineAsyncComponent(() => tools.importVue(component, devMode))

  static menuToImportVue = (component: string, devMode = false) => tools.importVue(component, devMode)

  static importVue = (component: string, devMode = false) => {
    if (component.indexOf('components/') != -1) {
      const path = component.split('components/')
      return import(`src/components/${path[1]}`)
    } else if (component.indexOf('_dev/pages/') != -1) {
      const path = component.split('_dev/pages/')
      return import(`src/_dev/pages/${path[1]}`)
    } else if (component.indexOf('pages/') != -1) {
      const path = component.split('pages/')
      return import(`src/pages/${path[1]}`)
    }
    return devMode ? import(`src/_dev/pages/${component}`) : import(`src/pages/${component}`)
  }

  static scaleToFit(img: HTMLImageElement, canvas: HTMLCanvasElement, context: CanvasRenderingContext2D | null = null) {
    if (context == null) {
      context = canvas.getContext('2d')
    }
    const width = img.naturalWidth
    const height = img.naturalHeight
    // get the scale
    const scale = Math.min(canvas.width / width, canvas.height / height)
    // get the top left position of the image
    const x = canvas.width / 2 - (width / 2) * scale
    const y = canvas.height / 2 - (height / 2) * scale
    context?.drawImage(img, x, y, width * scale, height * scale)
  }

  static scaleToFill(img: HTMLImageElement, canvas: HTMLCanvasElement, context: CanvasRenderingContext2D | null = null) {
    if (context == null) {
      context = canvas.getContext('2d')
    }
    const width = img.naturalWidth
    const height = img.naturalHeight
    // get the scale
    const scale = Math.max(canvas.width / width, canvas.height / height)
    // get the top left position of the image
    const x = canvas.width / 2 - (width / 2) * scale
    const y = canvas.height / 2 - (height / 2) * scale
    context?.drawImage(img, x, y, width * scale, height * scale)
  }

  static focusReset(input: any) {
    input.resetValidation()
  }
}

export default tools
