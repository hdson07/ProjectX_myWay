#!/usr/bin/env python
# coding: utf-8

# In[1]:


import cv2
import numpy as np
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import pytesseract
plt.style.use('dark_background')

# # Read Input Image

# In[2]:

cam = cv2.VideoCapture(0)
car = '차량 대기중'
resultShow = cv2.imread('none.png',cv2.IMREAD_COLOR)
org = 350


while(1) : 
        #카메라에서 이미지 얻음
    _, frame = cam.read()
    
    #BGR 색구성을 HSV로 변환
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    
    #HSV에서 측정할 값들의 최소값과 최대값을 지정


    lower_red = np.array([0,31,255])
    upper_red = np.array([176,255,255])
    
    #해당 이미지에서 최소값과 최대값의 범위 내의 색상을 제외한 다른 부분은 다 0으로 표기
    mask = cv2.inRange(hsv, lower_red, upper_red)
    
    #현재 출력 중인 인자로 부여된 이미지를 mask 값이 0이 아닌 부분과 AND 연산
    #각 색상이 추출된 부분만 해당 색상으로 보여짐
    res = cv2.bitwise_and(frame,frame, mask= mask)

 
    
    
    #mask 화면에 0이 아닌 값들의 수
    a= cv2.countNonZero(mask)
    
    # a 값은 차가 화면에 들어오는 면적에 따라 조절해줘야 할듯
    disable = False
    if a>1000: 
        disable = True
    else:
        disable = False
    ret, frame = cam.read()
    cv2.imwrite('messigray.jpg',frame, params=[cv2.IMWRITE_PNG_COMPRESSION,0])
    img_ori = cv2.imread('messigray.jpg',cv2.IMREAD_COLOR)


    height, width, channel = img_ori.shape

    # plt.figure(figsize=(12, 10))
    # plt.imshow(img_ori, cmap='gray')


    # # Convert Image to Grayscale

    # In[3]:


    # hsv = cv2.cvtColor(img_ori, cv2.COLOR_BGR2HSV)
    # gray = hsv[:,:,2]
    gray = cv2.cvtColor(img_ori, cv2.COLOR_BGR2GRAY)

    # plt.figure(figsize=(12, 10))
    # plt.imshow(gray, cmap='gray')


    # # Maximize Contrast (Optional)

    # In[15]:


    structuringElement = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))

    imgTopHat = cv2.morphologyEx(gray, cv2.MORPH_TOPHAT, structuringElement)
    imgBlackHat = cv2.morphologyEx(gray, cv2.MORPH_BLACKHAT, structuringElement)

    imgGrayscalePlusTopHat = cv2.add(gray, imgTopHat)
    gray = cv2.subtract(imgGrayscalePlusTopHat, imgBlackHat)

    # plt.figure(figsize=(12, 10))
    # plt.imshow(gray, cmap='gray')


    # # Adaptive Thresholding

    # In[4]:


    img_blurred = cv2.GaussianBlur(gray, ksize=(5, 5), sigmaX=0)

    img_thresh = cv2.adaptiveThreshold(
        img_blurred, 
        maxValue=255.0, 
        adaptiveMethod=cv2.ADAPTIVE_THRESH_GAUSSIAN_C, 
        thresholdType=cv2.THRESH_BINARY_INV, 
        blockSize=19, 
        C=9
    )

    # plt.figure(figsize=(12, 10))
    # plt.imshow(img_thresh, cmap='gray')

    # # Find Contours

    # In[5]:


    contours, _ = cv2.findContours(
        img_thresh, 
        mode=cv2.RETR_LIST, 
        method=cv2.CHAIN_APPROX_SIMPLE

    )


    temp_result = np.zeros((height, width, channel), dtype=np.uint8)

    cv2.drawContours(temp_result, contours=contours, contourIdx=-1, color=(255, 255, 255))

    # plt.figure(figsize=(12, 10))
    # plt.imshow(temp_result)


    # # Prepare Data

    # In[6]:


    temp_result = np.zeros((height, width, channel), dtype=np.uint8)

    contours_dict = []

    for contour in contours:
        x, y, w, h = cv2.boundingRect(contour)
        cv2.rectangle(temp_result, pt1=(x, y), pt2=(x+w, y+h), color=(255, 255, 255), thickness=2)
        
        # insert to dict
        contours_dict.append({
            'contour': contour,
            'x': x,
            'y': y,
            'w': w,
            'h': h,
            'cx': x + (w / 2),
            'cy': y + (h / 2)
        })

    # plt.figure(figsize=(12, 10))
    # plt.imshow(temp_result, cmap='gray')


    # # Select Candidates by Char Size

    # In[7]:


    MIN_AREA = 80
    MIN_WIDTH, MIN_HEIGHT = 2, 8
    MIN_RATIO, MAX_RATIO = 0.25, 1.0

    possible_contours = []

    cnt = 0
    for d in contours_dict:
        area = d['w'] * d['h']
        ratio = d['w'] / d['h']
        
        if area > MIN_AREA     and d['w'] > MIN_WIDTH and d['h'] > MIN_HEIGHT     and MIN_RATIO < ratio < MAX_RATIO:
            d['idx'] = cnt
            cnt += 1
            possible_contours.append(d)
            
    # visualize possible contours
    temp_result = np.zeros((height, width, channel), dtype=np.uint8)

    for d in possible_contours:
    #     cv2.drawContours(temp_result, d['contour'], -1, (255, 255, 255))
        cv2.rectangle(temp_result, pt1=(d['x'], d['y']), pt2=(d['x']+d['w'], d['y']+d['h']), color=(255, 255, 255), thickness=2)

    # plt.figure(figsize=(12, 10))
    # plt.imshow(temp_result, cmap='gray')


    # # Select Candidates by Arrangement of Contours

    # In[8]:


    MAX_DIAG_MULTIPLYER = 5 # 5
    MAX_ANGLE_DIFF = 12.0 # 12.0
    MAX_AREA_DIFF = 0.5 # 0.5
    MAX_WIDTH_DIFF = 0.8
    MAX_HEIGHT_DIFF = 0.2
    MIN_N_MATCHED = 3 # 3

    def find_chars(contour_list):
        matched_result_idx = []
        
        for d1 in contour_list:
            matched_contours_idx = []
            for d2 in contour_list:
                if d1['idx'] == d2['idx']:
                    continue

                dx = abs(d1['cx'] - d2['cx'])
                dy = abs(d1['cy'] - d2['cy'])

                diagonal_length1 = np.sqrt(d1['w'] ** 2 + d1['h'] ** 2)

                distance = np.linalg.norm(np.array([d1['cx'], d1['cy']]) - np.array([d2['cx'], d2['cy']]))
                if dx == 0:
                    angle_diff = 90
                else:
                    angle_diff = np.degrees(np.arctan(dy / dx))
                area_diff = abs(d1['w'] * d1['h'] - d2['w'] * d2['h']) / (d1['w'] * d1['h'])
                width_diff = abs(d1['w'] - d2['w']) / d1['w']
                height_diff = abs(d1['h'] - d2['h']) / d1['h']

                if distance < diagonal_length1 * MAX_DIAG_MULTIPLYER             and angle_diff < MAX_ANGLE_DIFF and area_diff < MAX_AREA_DIFF             and width_diff < MAX_WIDTH_DIFF and height_diff < MAX_HEIGHT_DIFF:
                    matched_contours_idx.append(d2['idx'])

            # append this contour
            matched_contours_idx.append(d1['idx'])

            if len(matched_contours_idx) < MIN_N_MATCHED:
                continue

            matched_result_idx.append(matched_contours_idx)

            unmatched_contour_idx = []
            for d4 in contour_list:
                if d4['idx'] not in matched_contours_idx:
                    unmatched_contour_idx.append(d4['idx'])

            unmatched_contour = np.take(possible_contours, unmatched_contour_idx)
            
            # recursive
            recursive_contour_list = find_chars(unmatched_contour)
            
            for idx in recursive_contour_list:
                matched_result_idx.append(idx)

            break

        return matched_result_idx

    
        
    result_idx = find_chars(possible_contours)

    matched_result = []
    for idx_list in result_idx:
        matched_result.append(np.take(possible_contours, idx_list))

    # visualize possible contours
    temp_result = np.zeros((height, width, channel), dtype=np.uint8)

    for r in matched_result:
        for d in r:
    #         cv2.drawContours(temp_result, d['contour'], -1, (255, 255, 255))
            cv2.rectangle(temp_result, pt1=(d['x'], d['y']), pt2=(d['x']+d['w'], d['y']+d['h']), color=(255, 255, 255), thickness=2)

    # plt.figure(figsize=(12, 10))

    # plt.imshow(temp_result, cmap='gray')


    # # Rotate Plate Images

    # In[9]:


    PLATE_WIDTH_PADDING = 1.3 # 1.3
    PLATE_HEIGHT_PADDING = 1.5 # 1.5
    MIN_PLATE_RATIO = 3
    MAX_PLATE_RATIO = 10

    plate_imgs = []
    plate_infos = []

    for i, matched_chars in enumerate(matched_result):
        sorted_chars = sorted(matched_chars, key=lambda x: x['cx'])

        plate_cx = (sorted_chars[0]['cx'] + sorted_chars[-1]['cx']) / 2
        plate_cy = (sorted_chars[0]['cy'] + sorted_chars[-1]['cy']) / 2
        
        plate_width = (sorted_chars[-1]['x'] + sorted_chars[-1]['w'] - sorted_chars[0]['x']) * PLATE_WIDTH_PADDING
        
        sum_height = 0
        for d in sorted_chars:
            sum_height += d['h']

        plate_height = int(sum_height / len(sorted_chars) * PLATE_HEIGHT_PADDING)
        
        triangle_height = sorted_chars[-1]['cy'] - sorted_chars[0]['cy']
        triangle_hypotenus = np.linalg.norm(
            np.array([sorted_chars[0]['cx'], sorted_chars[0]['cy']]) - 
            np.array([sorted_chars[-1]['cx'], sorted_chars[-1]['cy']])
        )
        
        angle = np.degrees(np.arcsin(triangle_height / triangle_hypotenus))
        
        rotation_matrix = cv2.getRotationMatrix2D(center=(plate_cx, plate_cy), angle=angle, scale=1.0)
        
        img_rotated = cv2.warpAffine(img_thresh, M=rotation_matrix, dsize=(width, height))
        
        img_cropped = cv2.getRectSubPix(
            img_rotated, 
            patchSize=(int(plate_width), int(plate_height)), 
            center=(int(plate_cx), int(plate_cy))
        )
        
        if img_cropped.shape[1] / img_cropped.shape[0] < MIN_PLATE_RATIO or img_cropped.shape[1] / img_cropped.shape[0] < MIN_PLATE_RATIO > MAX_PLATE_RATIO:
            continue
        
        plate_imgs.append(img_cropped)
        plate_infos.append({
            'x': int(plate_cx - plate_width / 2),
            'y': int(plate_cy - plate_height / 2),
            'w': int(plate_width),
            'h': int(plate_height)
        })
        
        # plt.imshow(img_cropped, cmap='gray')



    # # Another Thresholding to Find Chars

    # In[10]:


    longest_idx, longest_text = -1, 0
    plate_chars = []
    img_result = temp_result
    for i, plate_img in enumerate(plate_imgs):
        plate_img = cv2.resize(plate_img, dsize=(0, 0), fx=1.6, fy=1.6)
        _, plate_img = cv2.threshold(plate_img, thresh=0.0, maxval=255.0, type=cv2.THRESH_BINARY | cv2.THRESH_OTSU)
        
        # find contours again (same as above)
        contours, _ = cv2.findContours(plate_img, mode=cv2.RETR_LIST, method=cv2.CHAIN_APPROX_SIMPLE)
        

        plate_min_x, plate_min_y = plate_img.shape[1], plate_img.shape[0]
        plate_max_x, plate_max_y = 0, 0

        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            
            area = w * h
            ratio = w / h

            if area > MIN_AREA         and w > MIN_WIDTH and h > MIN_HEIGHT         and MIN_RATIO < ratio < MAX_RATIO:
                if x < plate_min_x:
                    plate_min_x = x
                if y < plate_min_y:
                    plate_min_y = y
                if x + w > plate_max_x:
                    plate_max_x = x + w
                if y + h > plate_max_y:
                    plate_max_y = y + h
                    
        img_result = plate_img[plate_min_y:plate_max_y, plate_min_x:plate_max_x]
        
        img_result = cv2.GaussianBlur(img_result, ksize=(3, 3), sigmaX=0)
        _, img_result = cv2.threshold(img_result, thresh=0.0, maxval=255.0, type=cv2.THRESH_BINARY | cv2.THRESH_OTSU)
        img_result = cv2.copyMakeBorder(img_result, top=10, bottom=10, left=10, right=10, borderType=cv2.BORDER_CONSTANT, value=(0,0,0))

        chars = pytesseract.image_to_string(img_result, lang='eng', config='--psm 7 --oem 0')
        result_chars = ''
        has_digit = False

        N = len(chars)
        result_array = [-1 for x in range(N)]
        for i in range(0,N):
            try:
                result_array[i] = float(chars[i])

            except ValueError:
                result_array[i] = -1
                continue
        if N == 9 : 
            if((0<=int(result_array[0])<10)&(0<=int(result_array[1])<10)&(0<=int(result_array[6])<10)&(0<=int(result_array[7])<10)&(0<=int(result_array[8])<10)&(0<=int(result_array[0])<10)):
                if disable:
                    if car=='장애인':
                        continue
                    else:
                        car = '장애인'
                        inputText = chars
                        resultShow = cv2.imread('go.png',cv2.IMREAD_COLOR)
                        cv2.putText(resultShow, inputText, (org,100), cv2.FONT_HERSHEY_PLAIN, 5, (255, 255, 255),thickness= 2)   
                        print(car + '\n')
                else : 
                    if (int(result_array[0])* 10 + int(result_array[1])) < 70 :
                        if car == '승용차' or disable == True:
                            continue
                        else :
                            car = '승용차'
                            inputText = chars
                            resultShow = cv2.imread('turnRight.png',cv2.IMREAD_COLOR)
                            cv2.putText(resultShow, inputText, (org,100), cv2.FONT_HERSHEY_PLAIN, 5, (255, 255, 255),thickness= 2)   
                            print(car + '\n')
                    elif (int(result_array[0])* 10 + int(result_array[1])) >= 70  and (int(result_array[0])* 10 + int(result_array[1])) < 100 :
                        if car == '대형차' or disable == True : 
                            continue
                        else :
                            car = '대형차'
                            inputText =  chars
                            resultShow = cv2.imread('turnLeft.png',cv2.IMREAD_COLOR)
                            cv2.putText(resultShow, inputText, (org,100), cv2.FONT_HERSHEY_PLAIN, 5, (255, 255, 255),thickness= 2)   
                            print(car + '\n')
                

        # plt.imshow(img_result, cmap='gray')


    # # Result

    # In[11]:


    # info = plate_infos[longest_idx]
    # chars = plate_chars[longest_idx]

    # print(chars)

    # img_out = img_ori.copy()

    # cv2.rectangle(img_out, pt1=(info['x'], info['y']), pt2=(info['x']+info['w'], info['y']+info['h']), color=(255,0,0), thickness=2)

    # cv2.imwrite(chars + '.jpg', img_out)

    # plt.figure(figsize=(12, 10))
    # plt.imshow(img_out)
    if img_result is not None:
         cv2.imshow('resultData',img_result)
         cv2.imshow('initial_data',img_ori)
         cv2.imshow('resultShow',resultShow)
         cv2.imshow('res',res) 
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break
cv2.destroyAllWindows()
cam.release()


# In[ ]:




