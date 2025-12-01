# PrestaShop Product Image Uploader (PowerShell)

A simple PowerShell script for bulk-uploading product images to **PrestaShop 8+** via the Webservice API.  
Images are matched to products by filename — e.g. `3501.png` uploads to product ID **3501**.

> ⚠️ **Important:**  
> - Script is **tested only in PowerShell 7+** (PowerShell Core).  
> - **Windows PowerShell 5.1 is not supported.**  
> - Requires **PrestaShop 8.x** with Webservice enabled.

---

## Features

- Bulk upload images using the PrestaShop Webservice API  
- Matches product IDs automatically from filenames  
- Supports `.png`, `.jpg`, `.jpeg`, `.webp`  
- No external modules required  
- Simple configuration and reliable operation  

---

## Requirements

### PrestaShop 8+
- Go to **Advanced Parameters → Webservice**
- Enable: **Enable PrestaShop’s webservice**
- Create a Webservice Key with at least:
  - `images` → **GET**, **POST**
  - `products` → **GET** (optional unless extending the script)

### PowerShell
- **PowerShell 7+** (PowerShell Core)  
  Install from Microsoft Store or:  
  https://github.com/PowerShell/PowerShell/releases

### Image folder
Your image directory should contain image files named with their product IDs.
3501.png
3343.jpg
9921.webp



