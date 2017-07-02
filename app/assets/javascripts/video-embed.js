function getEmbedVideoCode(url, width, height){
	if(!width){
		width = 854;
	}	
	
	if(!height){
		height = 480;
	}
	
	if(url != null && url != undefined){
		if(url.search("^https:\/\/www\.youtube\.com\/watch[?]{1}v=[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = url.indexOf("v=") + 2;
			var length = url.indexOf("&") - start;

			if(length < 0){
				length = url.length - start;
			}			
			
			return "<iframe width='"+width+"' height='"+height+"' src='https://www.youtube.com/embed/"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("^https:\/\/youtu\.be\/[-a-zA-Z0-9@:%_\+.~#?&//=]*$") != -1){
			var start = 17;			
			var length = url.indexOf("?");	

			if(length == -1){
				length = url.length - start;
			}
			
			return "<iframe width='"+width+"' height='"+height+"' src='https://www.youtube.com/embed/"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("^https:\/\/www\.youtube\.com\/embed\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = 0;
			var length = url.length - start;	

			return "<iframe width='"+width+"' height='"+height+"' src='"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("^https:\/\/vimeo\.com\/[0-9]+[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = 18;
			var length = url.indexOf("?");

			if(length == -1){
				length = url.length - start;
			}
			
			return "<iframe width='"+width+"' height='"+height+"' src='https://player.vimeo.com/video/"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("^https:\/\/player\.vimeo\.com\/video\/[0-9]+[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = 0;
			var length = url.length - start;

			return "<iframe width='"+width+"' height='"+height+"' src='"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("^https:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*wistia\.com\/medias\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = url.search("medias/") + 7;
			var length = url.indexOf("?");	

			if(length == -1){
				length = url.length - start;
			}

			return "<iframe src='//fast.wistia.net/embed/iframe/"+url.substr(start,length)+"?videoFoam=true' allowtransparency='true' frameborder='0' scrolling='no' allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width='"+width+"' height='"+height+"'></iframe>";
		}
		else if(url.search("^(http:|https:)\/\/fast\.wistia\.com\/embed\/medias\/[a-zA-Z0-9]+\.jsonp$") != -1){
			var start = url.indexOf("medias/") + 7;
			var length = url.indexOf(".jsonp");	

			return "<iframe src='//fast.wistia.net/embed/iframe/"+url.substr(start,length)+"?videoFoam=true' allowtransparency='true' frameborder='0' scrolling='no' allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width='"+width+"' height='"+height+"'></iframe>";
		}
		else if(url.search("https:\/\/www\.kickstarter.com\/projects\/[a-z0-9\-]+\/[a-z0-9\-]+\/widget\/video\.html$") != -1){
			var start = 0;
			var length = url.length;

			return "<iframe width='"+width+"' height='"+height+"' src='"+url.substr(start,length)+"' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
		else if(url.search("https:\/\/www\.kickstarter.com\/projects\/[a-zA-Z0-9\-]+\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*$") != -1){
			var start = 0;
			var length = url.indexOf("?");
			
			if(length == -1){
				length = url.length - start;
			}

			return "<iframe width='"+width+"' height='"+height+"' src='"+url.substr(start,length)+"/widget/video.html' frameborder='0' webkitallowfullscreen mozallowfullscreen scrolling='no' allowfullscreen></iframe>";
		}
	}
	
	return url;
};