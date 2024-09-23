import { updateImagePreviews } from './updateImagePreviews';
import { getFilesArray } from './handleFileSelect';

export function handleRemove(index) {
  let filesArray = getFilesArray();
  filesArray = filesArray.filter((_, i) => i !== index); // Remove file at the specified index
  updateImagePreviews(filesArray); // Update previews after removal
}
