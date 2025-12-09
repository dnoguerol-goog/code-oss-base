#!/bin/bash
# v1.0 Dan Noguerol

# Define colors for friendly output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Clear the screen for a fresh start
clear

echo -e "${CYAN}   _  _
  ( '   )_
 (    _    )_
(_  _(_ ,  _)_)
${NC}"
echo -e "${CYAN}Welcome to the Cloud Space CLI setup!${NC}"
echo "We are going to authenticate you in two steps."
echo ""
echo -e "${YELLOW}Step 1: Standard User Login${NC}"
echo "Press any key to authenticate with Google Cloud..."
read -n 1 -s -r
echo ""

echo -e "${CYAN}Running ${GREEN}gcloud auth login${NC}..."
echo -e "📝 ${CYAN}Pro-tip: You can hold down the Ctrl key (or Cmd on Mac) and click the link below to open it.${NC}"
echo -e "📝 ${CYAN}Pro-tip: If you can't seem to paste, check for a subtle confirmation dialog in the upper left.${NC}"
echo "----------------------------------------------------------------"

# Run standard login
gcloud auth login

echo ""
echo "----------------------------------------------------------------"
echo -e "${GREEN}Awesome! First step complete.${NC}"
echo ""
echo -e "${YELLOW}Step 2: Application Default Credentials${NC}"
echo "We need to authenticate one more time for local application defaults."
echo "Press any key to continue..."
read -n 1 -s -r
echo ""

echo -e "${CYAN}Running ${GREEN}gcloud auth application-default login${NC}..."
echo -e "📝 ${CYAN}Pro-tip: You can hold down the Ctrl key (or Cmd on Mac) and click the link below to open it.${NC}"
echo "----------------------------------------------------------------"

# Run ADC login
gcloud auth application-default login

echo ""
echo "----------------------------------------------------------------"
echo "Configuring git credentials for Cloud Source Repositories..."

# Run git config
git config --global credential.'https://*.*.sourcemanager.dev'.helper gcloud.sh

echo -e "${GREEN}Configuration finished!${NC}"
echo ""

# Check for specific tools (adk, uv, and gemini)

echo "Checking for available tools..."

found_tools=()

if command -v adk &> /dev/null; then

    found_tools+=("adk (Agent Developer Kit)")

fi

if command -v uv &> /dev/null; then

    found_tools+=("uv (UV Package Manager)")

fi

if command -v gemini &> /dev/null; then

    found_tools+=("gemini (Gemini CLI)")

fi



echo "----------------------------------------------------------------"

echo -e "${CYAN}Setup is complete!${NC} 🎉\n"



if [ ${#found_tools[@]} -eq 0 ]; then

    echo "Neither 'adk', 'uv', or 'gemini' were found in your path."

else

    echo "The following tools are available for you to use:"

    for tool in "${found_tools[@]}"; do

        echo -e "${GREEN}${tool}${NC}"

    done

fi

echo -e "----------------------------------------------------------------\n"
