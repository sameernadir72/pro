import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTwitter, faEthereum } from "@fortawesome/free-brands-svg-icons";
const Footer = () => {
  return (
    <footer class="footer pt-8 pb-6 relative container  p-6 ">
      <div>
        <div class="flex-auto flex-wrap text-center lg:text-center">
          <div class="w-full  px-4 flex-auto">
            
            <div class="mt-6 lg:mb-0 mb-6">
              <a
                class=" text-lightBlue-400 shadow-lg font-normal h-10 w-10 items-center justify-center align-center rounded-full outline-none focus:outline-none mr-4"
                href="https://twitter.com/bbanft"
              >
                <FontAwesomeIcon icon={faTwitter} />
              </a>
              <a
                class=" text-lightBlue-600 shadow-lg font-normal h-10 w-10 items-center justify-center align-center rounded-full outline-none focus:outline-none mr-2"
                href="/"
              >
                <FontAwesomeIcon icon={faEthereum} />
              </a>
            </div>
          </div>
        </div>
        <hr class="my-6 border-blueGray-300" />
        <div class="flex flex-wrap items-center md:justify-between justify-center">
          <div class="w-full md:w-4/12 px-4 mx-auto text-center">
            <div class="text-sm text-blueGray-500 font-semibold py-1">
              Copyright © <span id="get-current-year">2021</span>
              <a href="/" class="text-blueGray-500 hover:text-gray-800" target="_blank">
                {" "}
                Notus JS by
              </a>
              <a href="/" class="text-blueGray-500 hover:text-blueGray-800">
                Creative Tim
              </a>
              .
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
