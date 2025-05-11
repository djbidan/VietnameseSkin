// ==UserScript==
// @name         Auto Answer From GitHub
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Tự động chọn đáp án từ file GitHub
// @match        https://example.com/*
// @grant        GM_xmlhttpRequest
// @connect      raw.githubusercontent.com
// ==/UserScript==

(function() {
    'use strict';

    let answerMap = {};

    // 1. Load file JSON từ GitHub
    GM_xmlhttpRequest({
        method: "GET",
        url: "djbidan/Terminal/okkv/answers.json,
        onload: function(response) {
            try {
                answerMap = JSON.parse(response.responseText);
                console.log("Dữ liệu đã tải:", answerMap);
            } catch (e) {
                console.error("Không đọc được JSON:", e);
            }
        }
    });

    // 2. Tự động chọn đáp án
    function autoSelectAnswer() {
        const questionEl = document.querySelector('.question'); // Cập nhật selector
        if (!questionEl) return;

        const questionText = questionEl.textContent.trim();
        const correctOption = answerMap[questionText];
        if (!correctOption) return;

        // Ví dụ mỗi lựa chọn có class: option hoặc chứa "A :", "B :", ...
        const options = document.querySelectorAll('.option'); // cập nhật selector
        options.forEach(option => {
            const text = option.textContent.trim();
            if (text.startsWith(correctOption + ' :')) {
                option.click();
            }
        });
    }

    setInterval(autoSelectAnswer, 1000);
})();
