const assert = require('assert');
const firebase = require('@firebase/testing');

const MY_PROJECT_ID = 'flutter-firebase-dev-bbe40';

// // 対象のルールファイルの明示
// const rules = fs.readFileSync('../firestore.rules', 'utf-8');

// 自分のユーザー ID とメールアドレス（仮）
const myUserId = 'my_user_id';
const myEmail = 'my_email@example.com';

// 他人のユーザー ID とメールアドレス（仮）
const theirUserId = 'their_user_id';
const theirEmail = 'their_email@example.com';

// 自分のアカウント認証情報
const myAuth = {
    uid: myUserId, 
    email: myEmail,
};

const theirAuth = {
    uid: theirUserId,
    email: theirEmail,
}

describe("test",()=>{
    it("test", ()=>{
        assert.equal(2+2,4);
    });
})