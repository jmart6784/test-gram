// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Font awesome
require("@fortawesome/fontawesome-free");

// nav bar drop down logic
document.addEventListener("turbolinks:load", () => {
  let profPic = document.getElementById("nav-prof-pic");
  let dropDiv = document.getElementById("nav-drop-content");

  profPic.addEventListener("click", () => {
    if (dropDiv.style.display === "block") {
      dropDiv.style.display = "none";
    } else {
      dropDiv.style.display = "block";
    }
  });

  document.addEventListener("click", (e) => {
    if (e.target.id != "nav-prof-pic") {
      dropDiv.style.display = "none";
    }
  });
});

// Tinted tiles hover logic
document.addEventListener("turbolinks:load", () => {
  let tintedTiles = document.querySelectorAll(".tinted-tile");

  tintedTiles.forEach((tile) => {
    tile.addEventListener("mouseenter", () => {
      tile.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
      tile.childNodes[1].style.display = "block";
    });

    tile.addEventListener("mouseleave", () => {
      tile.style.backgroundColor = "rgba(0, 0, 0, 0.0)";
      tile.childNodes[1].style.display = "none";
    });
  });
});

// Post-show
document.addEventListener("turbolinks:load", () => {
  let viewAllLink = document.getElementById("view-all-mobile-comment-section");
  let comIcon = document.getElementById("post-show-mob-com-section");
  let mobileCommentsDiv = document.getElementById("mobile-full-comment-container");
  let mobileCommentsBackIcon = document.getElementById("mob-com-close");

  const openMobComments = () => {
    mobileCommentsDiv.style.display = "block";
  };

  const closeMobComments = () => {
    mobileCommentsDiv.style.display = "none";
  };

  comIcon.addEventListener("click", openMobComments);
  mobileCommentsBackIcon.addEventListener("click", closeMobComments);
  viewAllLink.addEventListener("click", openMobComments);
});

// Click Styled File button
document.addEventListener("turbolinks:load", () => {
  let originalFileInput = document.getElementById("primary-file-input")
  let styledButton = document.getElementById("choose-file");

  styledButton.addEventListener("click", () => {
    originalFileInput.click();
  });
});

// Private messages automatic scroll to bottom
document.addEventListener("turbolinks:load", () => {
  let msgDiv = document.getElementById("messages-parent-div");

  msgDiv.scrollTo(0, msgDiv.scrollHeight);
});

// Show more/less text logic
document.addEventListener("turbolinks:load", () => {
  let showMoreSpans = document.querySelectorAll(".show-more");
  let showLessSpans = document.querySelectorAll(".show-less");

  showMoreSpans.forEach(span => {
    span.addEventListener("click", () => {
      span.style.display = "none";
      span.nextElementSibling.style.display = "inline";
      span.nextElementSibling.nextElementSibling.style.display = "inline";
    });
  });

  showLessSpans.forEach(span => {
    span.addEventListener("click", () => {
      span.style.display = "none";
      span.previousElementSibling.style.display = "none";
      span.previousElementSibling.previousElementSibling.style.display = "inline";
    });
  });
});

// Edit user settings page, delete account drop down, and show/hide new password fields
document.addEventListener("turbolinks:load", () => {
  let delText = document.getElementById("edit-user-title");
  let delBtn = document.getElementById("edit-user-delete");

  delBtn.style.display = "none";

  delText.addEventListener("click", () => {
    if (delBtn.style.display === "none") {
      delBtn.style.display = "block";
    } else {
      delBtn.style.display = "none";
    }
  });

  let newPwrdField = document.getElementById("edit-user-new-password");
  let newPass1 = document.getElementById("edit-user-confirm-p1");
  let newPass2 = document.getElementById("edit-user-confirm-p2");

  newPwrdField.addEventListener("input", () => {
    if (newPwrdField.value.length === 0) {
      newPass1.style.display = "none";
      newPass2.style.display = "none";
    } else {
      newPass1.style.display = "grid";
      newPass2.style.display = "grid";
    }
  });
});

// Press show more btn automatically for endless scroll
document.addEventListener("DOMContentLoaded", () => {

  clickShowMore = () => {
    if(window.innerHeight + window.pageYOffset >= (document.body.offsetHeight)) {
      // Remove Event listener to avoid double clicking
      window.removeEventListener("scroll", clickShowMore);

      document.getElementById("more-link").click();

      setTimeout(() => {
        // Add event listener again
        window.addEventListener("scroll", clickShowMore);
      }, 1000);
    }
  };

  window.addEventListener("scroll", clickShowMore);
});

// Back to top Button
document.addEventListener("turbolinks:load", () => {

  document.getElementById("top-link").addEventListener("click", () => {
    window.scrollTo(0,0);
  });

});

// Endless scroll comments desktop
document.addEventListener("turbolinks:load", () => {
  let parentDiv = document.getElementById("all-comments-div");
  let moreLink = document.getElementById("more-comments");

  let hitBottom = () => {
    if (parentDiv.scrollTop >= (parentDiv.scrollHeight - parentDiv.offsetHeight)) {
      // Remove Event listener to avoid double clicking
      parentDiv.removeEventListener("scroll", hitBottom);

      moreLink.click();

      setTimeout(() => {
        // Add event listener again
        parentDiv.addEventListener("scroll", hitBottom);
      }, 1000);
    }
  };

  parentDiv.addEventListener("scroll", hitBottom);
});

// Back to top Comments
document.addEventListener("turbolinks:load", () => {
  let parentDiv = document.getElementById("all-comments-div");

  document.getElementById("top-of-comments").addEventListener("click", () => {
    parentDiv.scrollTo(0,0);
  });

});

// Endless scroll comments mobile
document.addEventListener("turbolinks:load", () => {
  let parentDiv = document.getElementById("scrollable-mobile-comments");
  let moreLink = document.getElementById("more-comments2");

  let hitBottom = () => {
    if (parentDiv.scrollTop >= (parentDiv.scrollHeight - parentDiv.offsetHeight)) {
      // Remove Event listener to avoid double clicking
      parentDiv.removeEventListener("scroll", hitBottom);

      moreLink.click();

      setTimeout(() => {
        // Add event listener again
        parentDiv.addEventListener("scroll", hitBottom);
      }, 1000);
    }
  };

  parentDiv.addEventListener("scroll", hitBottom);
});

// Back to top mobile Comments
document.addEventListener("turbolinks:load", () => {
  let parentDiv = document.getElementById("scrollable-mobile-comments");

  document.getElementById("top-of-comments2").addEventListener("click", () => {
    parentDiv.scrollTo(0,0);
  });
});