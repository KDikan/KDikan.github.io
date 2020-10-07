console.log("mainlog", news);

const articles = news.articles;
const articlesList = document.querySelector("#articles");
const newPost = document.querySelector("#new-post");

function articleHTML(item) {
    let block = document.createElement("div");
    block.classList.add("article");


    let title = document.createElement("h2");
    title.classList.add("article-title");
    title.innerText = item.title;

    let description = document.createElement("p");
    description.classList.add("article-description");
    description.innerText = item.description;

    let author = document.createElement("p");
    author.classList.add("article-author");
    author.innerText = item.author;


    let source = document.createElement("p");
    source.classList.add("article-source");
    source.innerText = "Источник: " + item.source.name;

    let url = document.createElement("a");
    url.classList.add("article-link");
    url.innerText = "Подробнее...";
    url.href = item.url;

    let imageWrapper = document.createElement("div");
    imageWrapper.classList.add("image-wrapper");

    let image = document.createElement("img");
    image.classList.add("article-image");
    image.src = item.urlToImage;

    block.appendChild(imageWrapper);
    imageWrapper.appendChild(image);
    block.appendChild(title);
    block.appendChild(description);
    block.appendChild(url); 
    
    articlesList.appendChild(block);
};

articles.forEach(element => {
    articleHTML(element);
});

function addArticleHTML(post) {
    let block = document.createElement("div");
    let imageWrapper = document.createElement("div")
    let title = document.createElement("h2");
    let description = document.createElement("p");
    let url = document.createElement("a");
    let image = document.createElement("img");

    block.classList.add("article");
    imageWrapper.classList.add("image-wrapper")
    title.classList.add("article-title");
    description.classList.add("article-description");
    url.classList.add("article-link");
    image.classList.add("article-image");
 

    title.innerText = post.title;
    description.innerText = post.description;
    image.src = post.urlToImage;
    url.innerText = "Подробнее...";
    url.href = post.url;

    block.appendChild(imageWrapper);
    imageWrapper.appendChild(image);
    block.appendChild(title);
    block.appendChild(description);
    block.appendChild(url);

    articlesList.appendChild(block);
}

newPost.addEventListener("submit", event => {
    event.preventDefault();

    const addedPost = {};
    console.log("event", event);

    addedPost.title = event.target["0"].value;
    addedPost.description = event.target["1"].value;
    addedPost.url = event.target["2"].value;
    addedPost.urlToImage = event.target["3"].value;

    addArticleHTML(addedPost);
});