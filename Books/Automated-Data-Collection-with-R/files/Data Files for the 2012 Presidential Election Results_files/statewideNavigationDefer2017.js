window.gaAvailable = false;
(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date(); a = s.createElement(o),
    m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'egov');
egov('create', 'UA-31247043-4', 'none');
egov('send', 'pageview');
// Register GA callback to ensure GA is available
egov(function () {
    window.gaAvailable = true;
});

function showStatewideNavigation(color) {
    return writeLinks(verifyColor(color), "false");
}

function showStatewideNavigationWithTranslate(color) {
    writeCSS();


    return writeLinks(verifyColor(color), "true");
}

function showStatewideNavigationWithTranslate(color, customDisclaimerHTML) {
    writeCSS();
    //writeDisclaimer(customDisclaimerHTML);
    return writeLinks(verifyColor(color), "true");
}

function verifyColor(color) {
    // verify color is passed in 
    if (color)
        color = color.toLowerCase();
    else
        color = "white";

    // limit color selections
    switch (color) {
        case "black":
            color = "#000000";
            break;
        case "white":
            color = "#FFFFFF";
            //color = "#FEEDB9";
            break;
        default:
            color = "#FFFFFF";
            break;
    }

    return color;
}


function writeLinks(color, writeTranslate) {
    var div = '<div style="font-family: arial,verdana,helvetica,sans-serif; font-size: xx-small; color: ' + color + ';">';
    div += '<a class="hidden-phone" href="https://www.maryland.gov" target="_blank" style="padding: 0px 5px 0px 0px;">Maryland.gov</a>';
    div += '<a href="https://www.doit.state.md.us/phonebook/" target="_blank" style="padding: 0px 5px 0px 5px;">Phone Directory</a>';
    div += '<a href="https://www.maryland.gov/pages/agency_directory.aspx" target="_blank" style="padding: 0px 5px 0px 5px;">State Agencies</a>';
    div += '<a class="hidden-phone" href="https://www.maryland.gov/pages/online_services.aspx" target="_blank" style="padding: 0px 0px 0px 5px;">Online Services</a>';


    if (writeTranslate == "true") {

        div += '<a href="#" style="padding: 0px 0px 0px 10px;"  onclick="showLanguages();"><img src="https://www.maryland.gov/branding/translate_button.png" alt="Translate"  ></a>';
        writeLanguageList();

    }

    div += '</div>';
    return div;
}

function writeDisclaimer(customDislaimerHTML) {
    var disclaimer = ''; ///'<div id="overlay-background"></div>';

    //disclaimer += '<a href="#"  onclick="showDisclaimer()"><img src="egov/img/icons/close-icon.png" style="float:right;height: 30px;width:30px;margin-right:10px;" alt="Close window"></a><div id="translateMessage">';
    disclaimer += '<form id="translateForm"><label for="dislclaimerLanguageSelect">View Disclaimer in: </label><select id="dislclaimerLanguageSelect" name="dislclaimerLanguageSelect" onchange="selectDisclaimerLanguage(this);" >';
    disclaimer += '<option value="English">English</option>';
    disclaimer += '<option value="Spanish">Spanish</option>';
    disclaimer += '<option value="ChineseS">Chinese - Simplified</option>';
    disclaimer += '<option value="ChineseT">Chinese - Traditional</option></select>';


    var englishDisclaimerHTML = '<div id="English" class="Disclaimer"><h2>Google Translate Disclaimer</h2>';
    englishDisclaimerHTML += '<p>The Maryland Department of Information Technology (“DoIT”) offers translations of the content through Google Translate. Because Google Translate is an external website, DoIT does not control the quality or accuracy of translated content. All DoIT content is filtered through Google Translate which may result in unexpected and unpredictable degradation of portions of text, images and the general appearance on translated pages. Google Translate may maintain unique privacy and use policies. These policies are not controlled by DoIT and are not associated with DoIT’s privacy and use policies. After selecting a translation option, users will be notified that they are leaving DoIT’s website. Users should consult the original English content on DoIT’s website if there are any questions about the translated content.</p>';
    englishDisclaimerHTML += '<p>DoIT uses Google Translate to provide language translations of its content. Google Translate is a free, automated service that relies on data and technology ​​​to provide its translations. The Google Translate feature is provided for informational purposes only. Translations cannot be guaranteed as exact or without the inclusion of incorrect or inappropriate language. Google Translate is a third-party service and site users will be leaving DoIT to utilize translated content. As such, DoIT does not guarantee and does not accept responsibility for, the accuracy, reliability, or performance of this service nor the limitations provided by this service, such as the inability to translate specific files like PDFs and graphics (e.g. .jpgs, .gifs, etc.).</p>';
    englishDisclaimerHTML += '<p>DoIT provides Google Translate as an online tool for its users, but DoIT does not directly endorse the website or imply that it is the only solution available to users. All site visitors may choose to use alternate tools for their translation needs. Any individuals or parties that use DoIT content in translated form, whether by Google Translate or by any other translation services, do so at their own risk. DoIT is not liable for any loss or damages arising out of, or issues related to, the use of or reliance on translated content. DoIT assumes no liability for any site visitor’s activities in connection with use of the Google Translate functionality or content.</p>';
    englishDisclaimerHTML += '<p>The Google Translate service is a means by which DoIT offers translations of content and is meant solely for the convenience of non-English speaking users of the website. The translated content is provided directly and dynamically by Google; DoIT has no direct control over the translated content as it appears using this tool. Therefore, in all contexts, the English content, as directly provided by DoIT is to be held authoritative.</p></div>';
    //englishDisclaimerHTML += '<p><strong>Select a language to proceed to the Google Translate site.  All languages supported by Google Translate will be available.</strong></p><';

    var spanishDisclaimerHTML = '<div id="Spanish" class="Disclaimer" style="display:none;"><h2>Exención de Responsabilidad del Traductor Google</h2>';
    spanishDisclaimerHTML += '<p>El Departamento de Tecnología de la Información de Maryland (DoIT, siglas en inglés) ofrece traducciones del contenido a través del Traductor Google (Google Translate). Debido a que el Traductor Google es un sitio web externo, el DoIT no controla la calidad o exactitud del contenido traducido. Todo el contenido del DoIT es filtrado a través del Traductor Google lo que puede resultar en una degradación inesperada o impredecible de porciones del texto, imágenes y la apariencia general de las páginas traducidas. El Traductor Google puede mantener una política de uso y privacidad únicas. Estas políticas no son controladas por el DoIT y no están asociadas con las políticas de privacidad y uso del DoIT. Después de seleccionar una opción de traducción, los usuarios serán notificados de que están abandonando el sitio web del DoIT. Los usuarios deben consultar el contenido original en inglés en el sitio web del DoIT si tienen alguna pregunta acerca del contenido traducido.</p>';
    spanishDisclaimerHTML += '<p>El DoIT usa el Traductor Google para proporcionar traducciones lingüísticas de su contenido. El Traductor Google es un servicio gratis y automatizado que se basa en datos y tecnología para proporcionar sus traducciones. La función del Traductor Google es proporcionada solamente para propósitos informativos. Las traducciones no pueden ser garantizadas como exactas o sin la inclusión de lenguaje incorrecto o inapropiado. El Traductor Google es un servicio de terceros y los usuarios del sitio dejarán al DoIT para utilizar el contenido traducido. Como tal, el DoIT no garantiza y no acepta responsabilidad por la exactitud, confiabilidad o desempeño de este servicio o de las limitaciones proporcionadas por este servicio, tales como la inhabilidad de traducir archivos específicos como PDF y gráficos (p.e. .jpgs, .gifs, etc.).</p>';
    spanishDisclaimerHTML += '<p>El DoIT proporciona el Traductor Google como una herramienta en línea para sus usuarios, pero el DoIT no endosa directamente el sitio web o implica que es la única solución disponible para los usuarios. Todos los visitantes al sitio pueden escoger usar herramientas alternativas para sus necesidades de traducción. Cualquier persona que utilice el contenido del DoIT en su forma traducida, ya sea por el Traductor Google o por cualquier otro servicio de traducción, lo hace bajo su propio riesgo. El DoIT no es responsable por ninguna pérdida o daño que surja de, o problemas relacionados con el uso o dependencia del contenido traducido. El DoIT no asume ninguna responsabilidad por las actividades de los visitantes del sitio en conexión con el uso de la funcionalidad o contenido del Traductor Google.</p>';
    spanishDisclaimerHTML += '<p>El servicio del Traductor Google es un medio por el cual el DoIT ofrece traducciones de contenido y está destinado solamente para la conveniencia de los usuarios del sitio web que no hablan inglés. El contenido traducido es proporcionado directa y dinámicamente por Google; el DoIT no tiene control directo sobre el contenido traducido tal y como aparece utilizando esta herramienta. Por lo tanto, en todos los contextos, el contenido en inglés, tal y como se proporciona por el DoIT será considerado como el autorizado.</p></div>';

    //spanishDisclaimerHTML += '<p>Seleccione un idioma para proceder al sitio del Traductor Google. Todos los lenguajes soportados por el Traductor Google estarán disponibles.</p></div>';

    var chineseSDisclaimerHTML = '<div id="ChineseS" class="Disclaimer" style="display:none;"><h2>Google翻译免责声明</h2>';
    chineseSDisclaimerHTML += '<p>马里兰州信息技术部（DoIT）通过Google翻译（Google Translate）为其网站使用者提供网站内容翻译。由于Google翻译是一个外部网站，因此DoIT无法控制翻译内容的质量或准确性。所有经翻译的DoIT网站内容通过Google翻译过滤，因此有可能出现无法预期的某些文本内容、图像以及翻译页面被破坏的情况。Google翻译有可能保留独特的隐私权和使用政策。DoIT并不控制这些政策，且它们与DoIT本身的隐私权和使用政策无关。在做需要翻译的选择后，使用者将被告知其将离开DoIT网站。如果使用者对翻译后的内容有任何疑问，应以DoIT网站上的英文原文为准。</p>';
    chineseSDisclaimerHTML += '<p>DoIT使用Google翻译为其网站内容提供语言翻译服务。Google翻译是一项免费的自动服务，其依靠相关数据和技术来提供翻译服务。提供Google翻译服务的目的仅为提供相关信息，因此DoIT无法保证翻译后的内容与原文完全相同或不包含任何不正确或不适宜的语言。Google翻译是一项第三方服务，而DoIT网站使用者将离开DoIT网站以便查阅翻译后的内容。因此，DoIT并不保证这项服务的准确性、可靠性、质量和局限性（如这项服务无法翻译PDF、图形（如jpgs、gifs等）格式的文件），也不对此负责。</p>';
    chineseSDisclaimerHTML += '<p>Google翻译是DoIT为其网站使用者提供的一种网上工具。尽管如此，DoIT并不直接为该网站服务提供担保，也不表明使用者只能使用Google翻译提供的服务。所有DoIT网站访问者可以选择使用其它工具以满足其翻译需要。任何使用翻译后（无论是通过Google翻译还是通过其它翻译服务）的DoIT网站内容的个人或机构应自行承担风险。DoIT不对因使用或依赖翻译后的内容所造成的损失、损害或问题负责。DoIT不对任何网站访问者与使用Google翻译功能或内容相关的活动负责。</p>';
    chineseSDisclaimerHTML += '<p>Google翻译服务是DoIT为其网站使用者提供的一种翻译工具，其唯一的目的是为英语非母语的网站使用者提供方便。Google直接提供动态的内容翻译服务，而DoIT不直接控制翻译后的内容，即使其使用该工具。因此，在各种情况下，使用者应以DoIT为其直接提供的英文内容为准。</p></div>';

    //chineseSDisclaimerHTML += '<p>选择某一语言以进入Google翻译网站。在那里，您将找到Google翻译提供的全部语言服务。</p></div>';

    var chineseTDisclaimerHTML = '<div id="ChineseT" class="Disclaimer" style="display:none;"><h2>Google翻譯免責聲明</h2>';
    chineseTDisclaimerHTML += '<p>馬里蘭州信息技術部（DoIT）通過Google翻譯（Google Translate）為其網站使用者提供網站內容翻譯。由於Google翻譯是一個外部網站，因此DoIT無法控制翻譯內容的質量或準確性。所有經翻譯的DoIT網站內容通過Google翻譯過濾，因此有可能出現無法預期的某些文本內容、圖像以及翻譯頁面被破壞的情況。 Google翻譯有可能保留特定的隱私權和使用政策。這些政策不受DoIT控制，且與DoIT本身的隱私權和使用政策無關。在選擇需要翻譯的内容後，使用者將被告知其將離開DoIT網站。如果使用者對翻譯後的內容有任何疑問，應以DoIT網站上的英文原文為準。</p>';
    chineseTDisclaimerHTML += '<p>DoIT使用Google翻譯為其網站內容提供語言翻譯服務。 Google翻譯依靠相關數據和技術提供免費的自動化翻譯服務。提供Google翻譯服務的目的僅為提供相關信息，因此DoIT無法保證翻譯後的內容與原文完全相同或不包含任何不正確或不適宜的語言。 Google翻譯是一項第三方服務，且DoIT網站使用者將離開DoIT網站才能查閱翻譯後的內容。因此，DoIT並不保證這項服務的準確性、可靠性、質量或局限性（比如，這項服務無法翻譯PDF、圖形（如jpgs、gifs等）等格式的文件），也不對此負責。</p>';
    chineseTDisclaimerHTML += '<p>Google翻譯是DoIT為其網站使用者提供的一項網上工具。儘管如此，DoIT並不直接為該網站服務提供擔保，也不表明使用者只能使用Google翻譯提供的服務。所有DoIT網站訪問者可以選擇使用其它工具以滿足其翻譯需要。任何使用翻譯後（無論是通過Google翻譯還是通過其它翻譯服務）的DoIT網站內容的個人或機構應自行承擔風險。 DoIT不對因使用或依賴翻譯後的內容所造成的損失、損害或問題負責。 DoIT不對任何網站訪問者與使用Google翻譯功能或內容相關的活動負責。</p>';
    chineseTDisclaimerHTML += '<p>Google翻譯服務是DoIT為其網站使用者提供的一項翻譯工具，其唯一的目的是為英語非母語的網站使用者提供方便。 Google直接提供動態的內容翻譯服務，而DoIT不直接控制翻譯後的內容，即使其使用該工具。因此，在各種情況下，使用者應以DoIT為其直接提供的英文內容為準。</p></div>';

    //chineseTDisclaimerHTML += '<p>選擇某一語言來進入Google翻譯網站。在那裡，您會找到Google翻譯提供的全部語言服務。</p></div>';

    disclaimer += englishDisclaimerHTML;
    disclaimer += spanishDisclaimerHTML;
    disclaimer += chineseSDisclaimerHTML;
    disclaimer += chineseTDisclaimerHTML;


    disclaimer += '</form>';
    return disclaimer;

    //var disclaimerNode = document.createElement('div');
    //disclaimerNode.id = "overlay-background";
    //document.body.appendChild(disclaimerNode);

    //disclaimerNode = document.createElement('div');
    //disclaimerNode.id = "overlay";
    //disclaimerNode.innerHTML = disclaimer;

    //document.body.appendChild(disclaimerNode);
}

function writeLanguageList() {

    var startUrl = window.location.toString();

    if (startUrl.slice(-1) == "#") {
        var res = startUrl.substring(0, (startUrl.length - 1))
        startUrl = res;
    }
    var linkTo = 'https://translate.google.com/translate?hl=en&sl=en&u=' + startUrl + '&tl=';
    var menu = '';
    menu += '<div class="overlay-background"></div>';

    menu += '<div id="languages" class="row-fluid" ><a href="#"  onclick="showLanguages()"><img src="https://www.maryland.gov/branding/close-icon.png" style="float:right;height: 30px;width:30px;margin-right:10px;margin-top:10px;" alt="Close window"></a>';



    var langList = [
		['af', 'Afrikaans '],
		['sq', 'Albanian - shqiptar'],
		['am', 'Amharic - አማርኛ'],
        ['ar', 'Arabic -  عربى '],
		['hy', 'Armenian -Հայերէն '],
		['az', 'Azerbaijani - Azərbaycan'],
		['eu', 'Basque - Euskal '],
		['be', 'Belarusian -беларускі'],
		['bn', 'Bengali - বাঙালি'],
		['bs', 'Bosnian -  bBosanski '],
		['bg', 'Bulgarian - български '],
		['ca', 'Catalan - Català'],
		['ceb', 'Cebuano'],
		['ny', 'Chichewa'],
		['co', 'Corsican - Corsu'],
		['hr', 'Croatian - hrvatski'],
		['cs', 'Czech - čeština'],
		['da', 'Danish - dansk'],
		['nl', 'Dutch - Nederlands'],
		['eo', 'Esperanto'],
		['et', 'Estonian - Eesti keel'],
		['tl', 'Filipino'],
		['fi', 'Finnish - Suomalainen'],
		['fr', 'French - français'],
		['fy', 'Frisian - Frysk'],
		['gl', 'Galician - Galego'],
		['ka', 'Georgian - ქართული'],
		['de', 'German - Deutsche'],
		['el', 'Greek - Ελληνικά'],
		['gu', 'Gujarati - ગુજરાતી'],
		['ht', 'Haitian Creole - Kreyòl Ayisyen'],
		['ha', 'Hausa'],
		['haw', 'Hawaiian - ʻŌlelo Hawaiʻi'],
		['iw', 'Hebrew - עִברִית'],
		['hi', 'Hindi - हिंदी'],
		['hmn', 'Hmong - Hmoob'],
		['hu', 'Hungarian - Magyar'],
		['is', 'Icelandic - Íslensku'],
		['ig', 'Igbo'],
		['id', 'Indonesian - bahasa Indonesia'],
		['ga', 'Irish - Gaeilge'],
		['it', 'Italian - italiano'],
		['ja', 'Japanese - 日本語'],
		['jw', 'Javanese - Wong Jawa'],
		['kn', 'Kannada - ಕನ್ನಡ'],
		['kk', 'Kazakh - Қазақша'],
		['km', 'Khmer - ភាសាខ្មែរ'],
		['ko', 'Korean - 한국어'],
		['ku', 'Kurdish (Kurmanji) - Kurdî'],
		['ky', 'Kyrgyz - Кыргызча'],
		['lo', 'Lao - ລາວ'],
		['la', 'Latin - Latine'],
		['lv', 'Latvian - Latviešu'],
		['lt', 'Lithuanian - Lietuviškai'],
		['lb', 'Luxembourgish - lëtzebuergesch'],
		['mk', 'Macedonian - Македонски'],
		['mg', 'Malagasy'],
		['ms', 'Malay - Melayu'],
		['ml', 'Malayalam - മലയാളം'],
		['mt', 'Maltese - Malti'],
		['mi', 'Maori'],
		['mr', 'Marathi - मराठी'],
		['mn', 'Mongolian - Монгол хэл'],
		['my', 'Myanmar (Burmese) '],
		['ne', 'Nepali - नेपाली'],
		['no', 'Norwegian - norsk'],
		['ps', 'Pashto - پښتو'],
		['fa', 'Persian - فارسی'],
		['pl', 'Polish - Polskie'],
		['pt', 'Portuguese - Português'],
		['pa', 'Punjabi - ਪੰਜਾਬੀ'],
		['ro', 'Romanian - Română'],
		['ru', 'Russian - русский'],
		['sm', 'Samoan - Samoa'],
		['gd', 'Scots Gaelic - Gàidhlig na h-Alba'],
		['sr', 'Serbian - Српски'],
		['st', 'Sesotho'],
		['sn', 'Shona'],
		['sd', 'Sindhi - سنڌي'],
		['si', 'Sinhala - සිංහල'],
		['sk', 'Slovak - slovenský'],
		['sl', 'Slovenian - Slovenščina'],
		['so', 'Somali'],
		['su', 'Sundanese - Sunda'],
		['sw', 'Swahili - Kiswahili'],
		['sv', 'Swedish - svenska'],
		['tg', 'Tajik - Тоҷикӣ'],
		['ta', 'Tamil - தமிழ்'],
		['te', 'Telugu - తెలుగు'],
		['th', 'Thai - ไทย'],
		['tr', 'Turkish - Türk'],
		['uk', 'Ukrainian - Українська'],
		['ur', 'Urdu - اردو'],
		['uz', 'Uzbek - O&quot;zbek'],
		['vi', 'Vietnamese - Tiếng Việt'],
		['cy', 'Welsh - Cymraeg'],
		['xh', 'Xhosa - isiXhosa'],
		['yi', 'Yiddish - ייִדיש'],
		['yo', 'Yoruba - Yorùbá'],
		['zu', 'Zulu']
    ];




    menu += '<div class="span4">';
    menu += '<div class="LangDesc" id="BeginLink" tabindex="0">Using the translate feature with screen reading software requires having the synthesizer for the foreign language you request already installed on your screen reader.  NVDA users should use the e-Speak NG synthesizer. JAWS users should download and install Vocalizer Expressive voices. VoiceOver and Narrator users should download the appropriate voices directly from Apple and Microsoft.  To view the disclaimer, press down arrow until you hear the words “view disclaimer” and press enter.</div>';
    menu += '    <ul style="list-style:none;">';
    menu += '			<li ><a href="#"  onclick="showDisclaimer();">View Disclaimer</a></li>';
    menu += '			<li><a href="' + linkTo + 'es" class="translateLink">Spanish</a></li>';
    menu += '			<li><a href="' + linkTo + 'zh-CN" class="translateLink">Chinese - Simplified</a></li>';
    menu += '			<li><a href="' + linkTo + 'zh-TW" class="translateLink">Chinese - Traditional</a></li>';
    menu += '<hr>'
    for (i = 0; i < 30; i++) {
        menu += '<li><a href="' + linkTo + langList[i][0] + '" class="mdgov_iaLink translateLink" style="font-size: small;">' + langList[i][1] + '</a></li>';
    }

    menu += ' 		</ul></div>';

    menu += '<div class="span4" ><ul style="list-style:none;">';

    for (i = 30; i < 66; i++) {
        menu += '<li><a href="' + linkTo + langList[i][0] + '" class="mdgov_iaLink translateLink" style="font-size: small;">' + langList[i][1] + '</a></li>';
    }

    menu += ' 		</ul></div>';

    menu += '<div class="span3" ><ul style="list-style:none;">';

    for (i = 66; i < langList.length; i++) {
        menu += '<li><a href="' + linkTo + langList[i][0] + '" class="mdgov_iaLink translateLink" style="font-size: small;">' + langList[i][1] + '</a></li>';
    }

    menu += ' 		</ul></div>';


    menu += '</div>';
    menu += '<div id="translateMessage"><a href="#"  onclick="showDisclaimer()"><img src="https://www.maryland.gov/branding/close-icon.png" style="float: right;height: 30px;width: 30px;" alt="Close Disclaimer"></a>' + writeDisclaimer('') + '</div>';


    var menuNode = document.createElement('div');
    menuNode.id = "overlay-background";
    document.body.appendChild(menuNode);

    menuNode = document.createElement('div');
    menuNode.id = "overlay";
    menuNode.classList = "container-fluid";
    menuNode.innerHTML = menu;

    document.body.appendChild(menuNode);

    // Add GA Events
    $(document).ready(function () {
        $(menuNode).find('.translateLink').on('click', function (e) {
            var $link = $(this);
            if (window.gaAvailable) {
                e.preventDefault();
                egov('send', {
                    hitType: 'event',
                    eventCategory: 'EWF.Widgets.Header|||StatewideNav',
                    eventAction: 'Translate' + ' - ' + $link.text(),
                    eventLabel: document.location.href,
                    hitCallback: function () {
                        document.location = $link.attr('href');
                    }
                });
            }
        });
    });
}

function writeCSS() {

    var cssText = '';
    cssText += '#mdgov_sliverRight a:focus img, img:hover{ border-bottom: 1px solid white; }';
    cssText += '#overlay {visibility: hidden;position:absolute;left:0px;right: 0px; top: 0px; z-index: 21000; margin-left: auto; margin-right: auto; max-width: 900px;}';
    cssText += '#overlay #languages {width:100%;margin: 20px;background-color: #fff;border:3px solid #000;border-radius: 25px;padding: 20px;}';
    cssText += '#overlay:hover #languages { opacity:1}';

    cssText += '#overlay #translateMessage {display: none;margin: 20px;background-color: #fff;border:3px solid #000;border-radius:25px;padding: 20px;}';
    cssText += ' #overlay:hover #translateMessage { opacity:1}';
    cssText += '#overlay-background{height:100%;width:100%;position:fixed;top:0;left:0;opacity: 0.65;background-color:#000;z-index:20100;visibility:hidden;-ms-filter:"alpha(opacity=65)";filter: alpha(opacity=65);}'
    cssText += '.Disclaimer { }';
    cssText += '.LangDesc {position:absolute;left:-10000px;top:auto;width:1px;height:1px; overflow:hidden;}';
    cssText += '#translateLanguageSelect {height:30px;} #dislclaimerLanguageSelect {height:30px;}';
    cssText += '@media (max-width: 767px) { #overlay {width: 80%;} #overlay #translateMessage {margin: 20px 0;} }';
    cssText += '@media (max-width: 480px) { }';
    cssText += '#overlay #languages {margin: 20px 0; box-sizing: border-box;}';
    cssText += '#dislclaimerLanguageSelect {margin-bottom: 20px;}';


    var cssStyleNode = document.createElement('style');
    cssStyleNode.type = 'text/css';
    if ('styleSheet' in cssStyleNode)
        cssStyleNode.styleSheet.cssText = cssText;
    else
        cssStyleNode.appendChild(document.createTextNode(cssText));


    document.getElementsByTagName('head')[0].appendChild(cssStyleNode);
}


function showLanguages() {
    var over = document.getElementById("overlay");
    over.style.visibility = (over.style.visibility == "visible") ? "hidden" : "visible";

    var overBg = document.getElementById("overlay-background");
    overBg.style.visibility = (overBg.style.visibility == "visible") ? "hidden" : "visible";

    var lang = document.getElementById("languages");
    lang.style.display = (lang.style.display == "block") ? "none" : "block";

    document.getElementById("BeginLink").focus();
}

function showDisclaimer() {
    var translate = document.getElementById("translateMessage");
    translate.style.display = (translate.style.display == "block") ? "none" : "block";
    var lang = document.getElementById("languages");
    lang.style.display = (lang.style.display == "block") ? "none" : "block";

}

function selectDisclaimerLanguage(sel) {
    var translateForm = document.getElementById("translateForm");
    var selLang = document.getElementById("dislclaimerLanguageSelect");

    var disclaimerForm = document.getElementById("translateMessage");
    if (disclaimerForm != null) {
        var disclaimers = disclaimerForm.getElementsByClassName("Disclaimer");

        for (var a = 0; a < disclaimers.length; a++) {
            var d = disclaimers[a];

            if (d.id == selLang.options[selLang.selectedIndex].value)

                d.style.display = 'inherit';
            else d.style.display = 'none';
        }


    }
}

function selectTranslateLanguage(sel) {
    var translateForm = document.getElementById("translateForm");
    var selLang = document.getElementById("translateLanguageSelect");

    if (translateForm != null && sel != null && sel.value != '') {

        translateForm.tl.value = sel.value;
        translateForm.submit();

    }
}