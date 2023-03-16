//To make sure the service worker works when developing, the scope and start_url of the manifest should be set to '/PWA/'. 
//However, when the website is on the server both should be changed to '/'.

self.addEventListener("install",(installing)=>{
    console.log("Service Worker: I am being installed, hello world!");
  });
  
  self.addEventListener("activate",(activating)=>{	
    console.log("Service Worker: All systems online, ready to go!");
  });
  
  self.addEventListener("fetch",(fetching)=>{   
    console.log("Service Worker: User threw a ball, I need to fetch it!");
  });
  
  self.addEventListener("push",(pushing)=>{
      console.log("Service Worker: I received some push data, but because I am still very simple I don't know what to do with it :(");
  })
  