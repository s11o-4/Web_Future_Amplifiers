//Subtitule
const text = document.getElementById("fancy")
const strText = text.textContent; //content of the text
const splitText = strText.split("")
text.textContent = ""; // limpio el contenido para que no se vena doble por mi looṕ

//Measuements of the page
let width_now = screen.width
let height_now = screen.height


const splitTextFilter = splitText.filter(function(letter){
   if (letter != " " && letter != "\n") {
     return letter
   }  
})

for(let i = 0; i < splitTextFilter.length; i++){
  text.innerHTML += "<span class='span-sub'>" + splitTextFilter[i] + "</span>";// se repite eñ elemento. Por eso es que lo borro
}

let char = 0;
let timer = setInterval(onTick, 50);

function onTick(){
  const span = text.querySelectorAll('span')[char];
  span.classList.add('fade');
  char++ 
  if(char === splitTextFilter.length){
    complete();
    return;
  }
}

function complete(){
  clearInterval(timer); 
  timer = null;
}

//album
setInterval(function(){
  document.getElementById("content-grid").style.marginTop = "0%";
}, 2000)

//carousel
$('.carousel').carousel({
    interval: 1000
})




//Logo Future Amplifiers for cellphone

if (width_now <= 200 || width_now <= 500){
  document.getElementById("future_amplifiers").src = "./images/FuturAmplifiersV4_mini.jpg"
  document.getElementById("future_amplifiers").style.width = "350px"
}  
