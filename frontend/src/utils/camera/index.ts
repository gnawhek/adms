export function takePicture(takeTarget: string, callback: (base64: string | ArrayBuffer | null | undefined) => void, error?: (message: string) => void) {
  const takePicture: HTMLInputElement | null = document.querySelector(takeTarget)
  if (takePicture) {
    // Set events
    takePicture.onchange = (event: Event) => {
      // Get a reference to the taken picture or chosen file
      const files = (event.target as HTMLInputElement).files
      if (files && files.length > 0) {
        const file = files[0]
        try {
          // Fallback if createObjectURL is not supported
          const fileReader = new FileReader()
          fileReader.onload = function (event: ProgressEvent<FileReader>) {
            callback(event.target?.result)
          }
          fileReader.readAsDataURL(file)
        } catch (e) {
          callback(null)
          error && error('Neither createObjectURL or FileReader are supported')
        }
      } else {
        callback(null)
      }
    }
  } else {
    callback(null)
  }
}

export function convertBase64ToBlob(base64: string) {
  const splitBase64 = base64.split(',')
  const contentType = splitBase64[0].split(':')[1].split(';')[0]
  const data = splitBase64[1]

  const byteCharacters = atob(data)
  const byteNumbers = new Array(byteCharacters.length)
  for (let i = 0; i < byteCharacters.length; i++) {
    byteNumbers[i] = byteCharacters.charCodeAt(i)
  }
  const byteArray = new Uint8Array(byteNumbers)
  const blob = new Blob([byteArray], { type: contentType })

  return blob
}
