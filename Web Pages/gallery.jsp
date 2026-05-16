<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Gallery</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background: white;
      margin: 0;
      padding: 32px;
      text-align: center;
    }
    .navbar {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      background: #b48c8c;
      padding: 12px 60px;
      box-sizing: border-box;
      z-index: 1000;
      display: flex;
      justify-content: center;
    }
    .nav-container {
      max-width: 1740px;
      width: 100%;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: nowrap; /* prevent wrapping */
    }
    .nav-title {
      font-family: 'Playfair Display', serif;
      font-size: 24px;
      font-weight: bold;
      color: #fff;
      white-space: nowrap;
      flex-shrink: 0;
    }
    .nav-links {
      display: flex;
      gap: 20px;
      white-space: nowrap;
      flex-shrink: 0;
    }
    .nav-links a {
      color: #fff;
      font-family: 'Arial', sans-serif;
      font-size: 17px;
      font-weight: normal;
      text-decoration: none;
      transition: color 0.18s;
    }
    .nav-links a:hover {
      color: #e0e0e0;
    }
    .content {
      padding-top: 75px;
    }
    h1 {
      color: #b48c8c;
      margin-bottom: 32px;
    }
    img.gallery-photo {
      width: 310px;
      height: 220px;
      object-fit: cover;
      margin: 16px;
      border-radius: 8px;
      box-shadow: 0 2px 12px rgba(120,70,70,0.09);
      transition: transform 0.2s;
      cursor: pointer;
    }
    img.gallery-photo:hover {
      transform: scale(1.03);
      box-shadow: 0 6px 24px rgba(120,70,70,0.13);
    }
    .modal {
      display: none;
      position: fixed;
      z-index: 2000;
      left: 0; top: 0;
      width: 100vw; height: 100vh;
      background: rgba(0,0,0,0.80);
      align-items: center;
      justify-content: center;
    }
    .modal.open { display: flex; }
    .modal-content {
      background: transparent;
      border-radius: 12px;
      max-width: 94vw;
      max-height: 94vh;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
    }
    .modal-content img {
      max-width: 90vw;
      max-height: 90vh;
      border-radius: 12px;
      box-shadow: 0 4px 32px rgba(0,0,0,0.14);
    }
    .modal-close {
      position: absolute;
      top: 12px; right: 22px;
      font-size: 2.2rem;
      color: #fff;
      background: rgba(50,10,50,0.47);
      border: none;
      border-radius: 50%;
      cursor: pointer;
      padding: 4px 12px 8px 12px;
      z-index: 10;
      line-height: 2rem;
      transition: background 0.2s;
    }
    .modal-close:hover {
      background: #b48c8c;
    }
    @media (max-width: 650px) {
      img.gallery-photo {
        width: 94vw;
        height: auto;
        margin: 12px 0;
      }
      .modal-content img {
        max-width: 98vw;
        max-height: 70vh;
      }
    }
  </style>
</head>
<body>
    
    <nav style="background: #b48c8c; width: 94.09%; margin: 40px auto 0 auto; box-sizing: border-box; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center;">
       <div style="font-size: 24px; font-weight: bold; color: #fff; font-family: 'Playfair Display', serif;"><a href="start_page.html" style="color: white; text-decoration: none;">Eventastic</a></div>
       <ul style="display: flex; gap: 19.58px; list-style: none; margin: 0; padding: 0;">
        <li><a href="home.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Home</a></li>
        <li><a href="services.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Services</a></li>
        <li><a href="gallery.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Gallery</a></li>
        <li><a href="contact.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Contact</a></li>
        <li><a href="login.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Login</a></li>
       </ul>
    </nav>
  <div class="content">
    <h1>Eventastic Gallery</h1>
    
    <img src="https://i.im.ge/2025/08/16/JZr9BW.bengali-wedding-rituals-symbol-600nw-2135995765.jpeg" alt="Photo 1" class="gallery-photo" />
    <img src="https://i.im.ge/2025/08/16/JZr7Hq.WhatsApp-Image-2025-08-16-at-21-24-56-767e74be.jpeg" alt="Photo 2" class="gallery-photo" />
    <img src="https://i.im.ge/2025/08/16/JZrZKX.colourful-traditional-view-bengali-wedding-rituals-multiple-brass-made-bowls-plate-holding-fire-india-indian-170957977.jpeg" alt="Photo 3" class="gallery-photo" />
    <img src="https://i.im.ge/2025/08/16/JZlwFX.WhatsApp-Image-2025-08-16-at-21-24-55-871b5291.jpeg" alt="Photo 4" class="gallery-photo" />
    <img src="https://i.im.ge/2025/08/16/JZFjkc.Sankha-Porano-Bengali-Wedding-Rituals.jpeg" alt="Photo 5" class="gallery-photo" />
    <img src="https://i.im.ge/2025/08/16/JZF3t6.Indian-Wedding-Rituals-indian-couple.jpeg" alt="Photo 5" class="gallery-photo" />
  </div>
    
  <div class="modal" id="photo-modal">
    <div class="modal-content">
      <button class="modal-close" onclick="closeModal()">&times;</button>
      <img id="modal-img" src="" alt="Full Photo" />
    </div>
  </div>
  <script>
      
    // Open modal on click
    const photos = document.querySelectorAll('.gallery-photo');
    const modal = document.getElementById('photo-modal');
    const modalImg = document.getElementById('modal-img');
    function openModal(src) {
      modal.classList.add('open');
      modalImg.src = src;
    }
    function closeModal() {
      modal.classList.remove('open');
      modalImg.src = '';
    }
    photos.forEach(photo => {
      photo.addEventListener('click', () => openModal(photo.src));
    });
    // Close modal on click outside or escape
    modal.addEventListener('click', function(e) {
      if(e.target === modal) closeModal();
    });
    document.addEventListener('keydown', function(e) {
      if(e.key === "Escape") closeModal();
    });
  </script>
</body>
</html>