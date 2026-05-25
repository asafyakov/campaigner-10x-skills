#!/bin/bash
# ============================================
# קמפיינר 10X — סקריפט התקנה (Mac)
# ============================================
# מתקין: VS Code, Git, Node.js, Claude Code
# זמן: 5-10 דקות
# ============================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
CHECK="${GREEN}✓${NC}"
ARROW="${YELLOW}→${NC}"

echo ""
echo "============================================"
echo "   קמפיינר 10X — התקנה אוטומטית"
echo "============================================"
echo ""

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
    echo -e "${ARROW} מתקין Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add to PATH for Apple Silicon
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    fi
    echo -e "${CHECK} Homebrew מותקן"
else
    echo -e "${CHECK} Homebrew כבר מותקן"
fi

# --- Git ---
if ! command -v git &>/dev/null; then
    echo -e "${ARROW} מתקין Git..."
    brew install git
    echo -e "${CHECK} Git מותקן"
else
    echo -e "${CHECK} Git כבר מותקן"
fi

# --- Node.js ---
if ! command -v node &>/dev/null; then
    echo -e "${ARROW} מתקין Node.js..."
    brew install node
    echo -e "${CHECK} Node.js מותקן"
else
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        echo -e "${ARROW} Node.js ישן מדי ($(node -v)), מעדכן..."
        brew upgrade node
        echo -e "${CHECK} Node.js עודכן"
    else
        echo -e "${CHECK} Node.js כבר מותקן ($(node -v))"
    fi
fi

# --- VS Code ---
if ! command -v code &>/dev/null; then
    echo -e "${ARROW} מתקין VS Code..."
    brew install --cask visual-studio-code
    echo -e "${CHECK} VS Code מותקן"
else
    echo -e "${CHECK} VS Code כבר מותקן"
fi

# --- Claude Code CLI ---
if ! command -v claude &>/dev/null; then
    echo -e "${ARROW} מתקין Claude Code..."
    npm install -g @anthropic-ai/claude-code
    echo -e "${CHECK} Claude Code מותקן"
else
    echo -e "${CHECK} Claude Code כבר מותקן"
fi

# --- סקיל agency-setup ---
SKILL_DIR="$HOME/.claude/skills/agency-setup"
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo -e "${ARROW} מתקין סקיל /agency-setup..."
    mkdir -p "$SKILL_DIR"
    curl -fsSL "https://raw.githubusercontent.com/asafyakov/campaigner-10x-skills/main/agency-setup/SKILL.md" -o "$SKILL_DIR/SKILL.md" 2>/dev/null || echo -e "${YELLOW}⚠ לא הצלחתי להוריד — נתקין ידנית במפגש${NC}"
    echo -e "${CHECK} סקיל /agency-setup מותקן"
else
    echo -e "${CHECK} סקיל /agency-setup כבר מותקן"
fi

# --- סקיל meta-connect ---
SKILL_DIR2="$HOME/.claude/skills/meta-connect"
if [ ! -f "$SKILL_DIR2/SKILL.md" ]; then
    echo -e "${ARROW} מתקין סקיל /meta-connect..."
    mkdir -p "$SKILL_DIR2"
    curl -fsSL "https://raw.githubusercontent.com/asafyakov/campaigner-10x-skills/main/meta-connect/SKILL.md" -o "$SKILL_DIR2/SKILL.md" 2>/dev/null || echo -e "${YELLOW}⚠ לא הצלחתי להוריד — נתקין ידנית במפגש${NC}"
    echo -e "${CHECK} סקיל /meta-connect מותקן"
else
    echo -e "${CHECK} סקיל /meta-connect כבר מותקן"
fi

# --- יצירת תיקיית סוכנות ---
AGENCY_DIR="$HOME/Desktop/סוכנות"
if [ ! -d "$AGENCY_DIR" ]; then
    echo -e "${ARROW} יוצר תיקיית סוכנות על שולחן העבודה..."
    mkdir -p "$AGENCY_DIR"
    echo -e "${CHECK} תיקייה נוצרה: $AGENCY_DIR"
else
    echo -e "${CHECK} תיקיית סוכנות כבר קיימת"
fi

# --- סיכום ---
echo ""
echo "============================================"
echo "   ההתקנה הסתיימה!"
echo "============================================"
echo ""
echo -e "${CHECK} VS Code"
echo -e "${CHECK} Git"
echo -e "${CHECK} Node.js $(node -v)"
echo -e "${CHECK} Claude Code"
echo -e "${CHECK} תיקיית סוכנות: $AGENCY_DIR"
echo ""
echo "מה עכשיו?"
echo "1. פתחו VS Code"
echo "2. File → Open Folder → בחרו את תיקיית 'סוכנות'"
echo "3. פתחו Terminal (למטה) וכתבו: claude"
echo "4. כתבו: /agency-setup"
echo ""
echo "============================================"
