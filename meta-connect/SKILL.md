---
name: meta-connect
description: חיבור חשבון META לקלוד קוד — מדריך ליצירת טוקן, שליפת חשבונות/דפים/פיקסלים אוטומטית, ושמירה ב-CLAUDE.md.
allowed-tools: Bash, Read, Write, Edit
argument-hint: "[טוקן]"
---

# חיבור META — Meta Connect

סקיל שמחבר את חשבון המודעות של META לקלוד קוד. מדריך ליצירת טוקן, שולף הכל אוטומטית, ושומר ב-CLAUDE.md.

---

## 0. בדיקה — כבר מחובר?

בדוק אם יש סקשן "חיבור META" ב-CLAUDE.md בתיקייה הנוכחית.

אם כן — הצג את הפרטים ושאל:
> "כבר יש חיבור META:
> חשבון: [שם] — [act_ID]
> רוצה לעדכן טוקן / להחליף חשבון / לבדוק שהחיבור עובד?"

אם לא — המשך לשלב 1.

---

## 1. קבלת טוקן

בדוק אם המשתמש העביר טוקן כארגומנט. אם כן — דלג ישר לשלב 2.

אם לא — הדרך אותו צעד-צעד:

אמור:
> "בוא נחבר אותך ל-META. אני צריך טוקן כדי לגשת לחשבון המודעות שלך.
> 
> ככה מייצרים טוקן:
> 1. נכנסים ל-**developers.facebook.com** ומתחברים
> 2. לוחצים **My Apps** → **Create App**
> 3. בוחרים **Other** → **Business** → נותנים שם (למשל: 'סוכנות קלוד')
> 4. נכנסים ל-**Tools** → **Graph API Explorer**
> 5. בוחרים את ה-App שיצרתם למעלה
> 6. לוחצים **Add a Permission** ומסמנים:
>    - `ads_management`
>    - `ads_read`
>    - `pages_read_engagement`
>    - `pages_manage_ads`
>    - `business_management`
>    - `read_insights`
> 7. לוחצים **Generate Access Token** ומאשרים
> 8. **מעתיקים את הטוקן ומדביקים לי אותו פה**"

**חכה שהמשתמש ידביק את הטוקן.**

---

## 2. שליפת חשבונות מודעות

הרץ:

```bash
curl -s "https://graph.facebook.com/v21.0/me/adaccounts?fields=name,account_id,account_status,currency,timezone_name&access_token=TOKEN"
```

**אם נכשל** — אמור:
> "הטוקן לא עובד. בדוק שהעתקת את כל הטוקן ושהאפליקציה מחוברת ל-Business Manager.
> תדביק שוב?"

**אם הצליח** — הצג רשימה:
> "אלה חשבונות המודעות שלך:
> 1. [שם] — act_XXXXX (ILS)
> 2. [שם] — act_XXXXX (USD)
> 
> איזה חשבון לחבר?"

---

## 3. שליפת דפים

```bash
curl -s "https://graph.facebook.com/v21.0/me/accounts?fields=name,id&access_token=TOKEN"
```

הצג ושאל:
> "אלה הדפים שלך:
> 1. [שם] — ID: XXXXX
> 2. [שם] — ID: XXXXX
> 
> איזה דף לחבר?"

---

## 4. שליפת פיקסלים

```bash
curl -s "https://graph.facebook.com/v21.0/act_XXXXX/adspixels?fields=name,id&access_token=TOKEN"
```

אם יש פיקסל אחד — בחר אוטומטית.
אם יש כמה — הצג ושאל.
אם אין — אמור: "אין פיקסל בחשבון הזה. נמשיך בלי, אפשר להוסיף אחר כך."

---

## 5. אימות

הרץ בדיקה מהירה:

```bash
curl -s "https://graph.facebook.com/v21.0/act_XXXXX?fields=name,currency,timezone_name,amount_spent&access_token=TOKEN"
```

**שים לב:** amount_spent מוחזר באגורות/סנטים. חלק ב-100 לפני הצגה.

הצג:
> "✓ מחובר!
> חשבון: [שם]
> מטבע: [currency]
> אזור זמן: [timezone]
> הוצאה כוללת: [amount_spent / 100] [currency]"

---

## 6. שמירה ב-CLAUDE.md

קרא את CLAUDE.md בתיקייה הנוכחית.

**אם יש סקשן "חיבור META"** — עדכן אותו.
**אם אין** — הוסף אותו לפני הסקשן האחרון (לפני "מבנה הסוכנות" אם קיים, אחרת בסוף).

הסקשן שנוסף:

```markdown
## חיבור META
- Ad Account: [שם] — act_XXXXX
- Page: [שם] — XXXXX
- Pixel: [שם] — XXXXX
- Token: [הטוקן המלא]
- Currency: [ILS/USD]
- Timezone: [timezone]
- חיבור אחרון: [תאריך היום]

**לפני כל עבודה עם META — לוודא שהטוקן בתוקף.**
**טוקנים מ-Graph API Explorer פגים אחרי שעה. להאריך: App → Settings → Advanced → System User Token.**
```

---

## 7. סיום

אמור:
> "✅ META מחובר!
> מהרגע הזה כל סקיל שעובד עם פייסבוק (קמפיינים, אנליטיקס, קריאייטיבים) יודע לגשת לחשבון שלך.
> 
> ⚠️ שים לב: הטוקן מ-Graph API Explorer פג אחרי שעה.
> כדי לקבל טוקן שמחזיק 60 יום — צריך ליצור System User ב-Business Settings.
> רוצה שאדריך אותך?"

---

## 8. הארכת טוקן (אופציונלי — רק אם המשתמש ביקש)

אמור:
> "ככה מקבלים טוקן ל-60 יום:
> 1. נכנסים ל-**business.facebook.com** → **Settings** → **Users** → **System Users**
> 2. לוחצים **Add** → נותנים שם (למשל: 'claude-bot') → **Admin**
> 3. לוחצים **Add Assets** → מוסיפים את חשבון המודעות + הדפים
> 4. לוחצים **Generate New Token** → בוחרים את ה-App → מסמנים הרשאות → **Generate**
> 5. מעתיקים את הטוקן ומדביקים לי"

אחרי שמדביק — חזור לשלב 2 (שליפה ואימות) ועדכן את CLAUDE.md עם הטוקן החדש.
