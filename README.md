<div align="center">
<img width="850" height="200" alt="image" src="https://github.com/user-attachments/assets/995ab9d7-34dc-43a0-8a68-84bde4f75f90" />
</div>

<h1 align="center">Ecommerce Performance Report</h1>

<table align="center">
  <tr>
    <td width="1440">
      <h2 align="center">Client Background</h2>
      <body>
        <strong>PulseCommerce</strong> is a global e-commerce company that sells popular consumer electronics and accessories through web and mobile platforms. Founded in 2018, the company expanded rapidly and experienced major demand shifts during the COVID-19 period. <br>
        <br>
        <strong>PulseCommerce's</strong> book of business is approaching <strong>88,000</strong> customers and possesses over <strong>108,000</strong> transactions, generating sales revenue exceeding <strong>$28 million</strong>. The available eCommerce data spans various dimensions and metrics, including sales, products, sales by regions, and the company's loyalty program. <br>
        <br>
        Reporting to the Head of Operations, an analysis was conducted to evaluate <strong>PulseCommerce’s</strong> performance over the past several years and surface actionable insights for cross-functional teams. The key insights and recommendations focus on the following areas:
      </body>
    
<h3>Northstar Metrics</h3>
<ul>
  <li><strong>Sales trends</strong> - Tracking sales revenue, number of orders placed, and average order value (AOV) over time.</li>
  <li><strong>Product performance</strong> - Identifying top products and refund patterns to inform product and operations decisions.</li>
  <li><strong>Loyalty program evaluation</strong> - Comparing loyal vs. non-loyal customers to improve engagement and retention.</li>
  <li><strong>Regional results</strong> - Understanding demand differences across regions using the geo lookup table.</li>
</ul>

  </tr>
</table>




<div width="920">
    <h1 align="center">Executive Summary</h1>
</div>
<table align="center">
   <tr>   
  <div>
    <h3 align="center"> KPI Trends: AOV, Order count and Revenue from 2019 - 2022 </h3>
    <img width="1205" height="841" alt="SaleTrendElist" src="https://github.com/user-attachments/assets/5d624b04-cd2e-4b21-9ddb-ae29e011f0e9" />
  </div>
     <tr width="1440"> 
From 2019 to 2022, PulseCommerce generated <strong>$28.1M in total revenue</strong> across <strong>108K+ orders</strong>, with an <strong>average AOV of ~$260</strong>. Performance peaked in <strong>2020</strong>, culminating in <strong>$1.25M in monthly sales (Dec 2020)</strong>, followed by a sustained decline that bottomed out at <strong>$178K in Oct 2022</strong>.<br>
<br>
Across the period, <strong>revenue volatility is primarily driven by changes in order volume</strong>, not pricing. While AOV fluctuated within a relatively stable range ($216–$322), sharp revenue movements consistently aligned with expansions or contractions in order count. This explains periods where order volume remained elevated but revenue softened, as well as periods where stable AOV failed to offset declining demand.<br>
<br>
The 2022 downturn reflects a <strong>structural demand decline rather than an AOV collapse</strong>, signaling challenges in customer acquisition, retention, or purchase frequency. The sections that follow decompose this performance into its core drivers—sales trends, product mix, loyalty behavior, and regional dynamics—to identify where and why volume erosion occurred.<br><br>      
       </tr>
  </tr>

</table>
    
      

      

<h1 align="center">Dataset Structure</h1>
<div>
  The database structure as seen below consists of four tables: orders, customers, geo_lookup, and order_status, with a total row count of 108,127 records.
</div>
<div align="center">
  <img width="800" alt="image" src="https://github.com/user-attachments/assets/50346c48-8df6-4285-a964-a4c9c25ded2f" />
</div>








<h1 align="center">Insights Deep-Dive</h1>
<!-- SALES TRENDS -->
<table align="center">
  <tr>
    <h2 align="center">Sales Trend</h2>
    <td width="1000">
      <img width="1210" height="1066" alt="SaleTrend" src="https://github.com/user-attachments/assets/e2e85b1e-e9c4-492e-992f-4639b03bf4e9" />
    </td>
    <td width="1000">
      <img width="1213" height="1072" alt="AOV" src="https://github.com/user-attachments/assets/e71d9eeb-d899-4b0f-b184-ffb035878cbf" />
    </td>
    <td width="1000">
      <img width="1205" height="1056" alt="NumofOrderTrend" src="https://github.com/user-attachments/assets/970a5384-7744-47fd-bdca-84ffe2057ff1" />
    </td>
  </tr>
</table>

<table align="center">
  <tr>
    <td width="1440">
      <h3>Sales Revenue</h3> 
<ol>
        <li>
          Q4 2022 Collapse Breaks the “Holiday Peak” Pattern (Red-Flag Anomaly)
          <ul>
            <li>Historically, Q4 (Oct-Dec) is the strongest stretch of the year, but 2022 does the opposite - revenue falls off a cliff.</li>
            <li><strong>Oct 2022 hit $178K</strong>, the <strong>lowest month in the entire 2019-2022 window</strong>, then only partially recovered in <strong>Nov $208K</strong> and <strong>Dec $262K</strong>.</li>
            <li><strong>Dec 2022 ($262K)</strong> is down <strong>~70% vs Dec 2021 ($882K)</strong> and <strong>~79% vs Dec 2020 ($1.25M)</strong>.</li>
            <li>On a quarter level, <strong>Q4 2022 = $649K</strong>, down <strong>~72% vs Q4 2021 ($2.28M)</strong> and <strong>~79% vs Q4 2020 ($3.03M)</strong>.</li>
          </ul> 
        </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This indicates either (1) a real business shock (demand, competition, supply constraints), or (2) a <strong>data capture/completeness gap</strong> specifically impacting late-2022 reporting - either way, it is something stakeholders must validate before trusting forecasts.
</div>

  
<br>  
<li>
      Pandemic Demand Spike, then a Clear Post-Peak Normalization (2019-2022)
          <ul>
            <li>2019 is relatively steady (mostly <strong>$247K-$458K/month</strong>), then 2020 shows a step-change: <strong>Mar 2020 jumps to $720K</strong> and demand stays structurally higher through 2021.</li>
            <li>2020 peaks in <strong>Dec 2020 at $1.25M</strong> (highest month overall), showing strong seasonal + pandemic pull-forward.</li>
            <li>2021 remains elevated but cools vs 2020 (still many months in the <strong>$640K-$850K</strong> range).</li>
            <li>2022 trends downward most of the year (Jan <strong>$705K</strong> -&gt; Sep <strong>~$398K</strong>) before the Q4 crash.</li>
          </ul>
</li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This suggests the business rode a one-time demand tailwind in 2020, then faced weaker acquisition/retention efficiency or softer consumer spend by 2022.
</div>
</ol>

<strong>Why this matters to stakeholders</strong>
      <ul>
        <li><strong>Finance/Planning</strong>: If Q4 2022 is "real," it signals a major revenue risk and changes how you set targets and budgets. If it is "missing data," it creates false alarms and bad decisions.</li>
        <li><strong>Marketing</strong>: Q4 is where budgets are often highest; a Q4 breakdown suggests campaign performance, tracking, or channel ROI may have deteriorated.</li>
        <li><strong>Ops/Supply Chain</strong>: A sudden revenue drop can be consistent with stockouts, shipping limitations, or product availability issues - operational teams need to confirm whether inventory and fulfillment capacity matched demand.</li>
      </ul>
  

<br>
<h3>Average Order Value</h3>
<ol>
        <li>
          AOV Peaks in 2020, then Slides Back Toward 2019 Levels (Mix Shift Reversal)
          <ul>
            <li>AOV rises sharply during the 2020 surge, peaking at <strong>~$322 (Aug/Oct 2020 range)</strong>, compared to <strong>~$217-$245 in 2019</strong>.</li>
            <li>By 2021-2022, AOV drifts downward and stabilizes near pre-peak levels; <strong>2022 sits ~ $221-$256</strong>, with year-level AOV back around <strong>~$230</strong>.</li>
          </ul>
        </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This indicates 2020 likely had a higher-priced product mix (premium devices / higher basket sizes), and that mix did not hold post-peak.
</div>
  
<br>
<li>Q4 2022 AOV Drops - But Not Enough to Explain the Revenue Collapse
          <ul>
            <li><strong>Oct 2022 AOV is $216</strong> (lowest point), then <strong>Dec 2022 rebounds to ~$234</strong> - still not catastrophic on its own.</li>
            <li>Even in Q4, the bigger story is volume: AOV is down modestly, but revenue is down massively.</li>
          </ul>
        </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This suggests discounting, cheaper product mix, or fewer premium purchases in late 2022 - but AOV alone is not the root cause of the sales free-fall.
</div>
      </ol>

<strong>Why this matters to stakeholders</strong>
      <ul>
        <li><strong>Merchandising/Product</strong>: AOV trends reveal whether revenue changes are coming from <strong>pricing/mix</strong> vs customer traffic.</li>
        <li><strong>Marketing + Growth</strong>: If AOV is flat but revenue drops, acquisition and repeat purchase frequency are the bigger levers than upsell/cross-sell.</li>
        <li><strong>Leadership</strong>: AOV stability helps narrow the "why" quickly - preventing teams from blaming price changes when the real issue is demand or conversion.</li>
      </ul>


<br>
<h3>Order Count</h3>
<ol>
  <li>
          Revenue Decline is Primarily a Demand/Volume Problem (Not a Pricing Problem)
          <ul>
            <li>Order count tracks revenue extremely closely across the four years, which is a strong signal that <strong>volume is driving the business outcome</strong>.</li>
            <li>2020 scales up and peaks at <strong>4,019 orders (Dec 2020)</strong>, matching the revenue peak.</li>
            <li>2022 steadily decays and then breaks in Q4: <strong>Oct 2022 falls to 825 orders</strong>, then <strong>Dec 2022 only reaches 1,120</strong>.</li>
            <li><strong>Q4 2022 orders = 2,866</strong>, down <strong>~69% vs Q4 2021 (9,366)</strong> and <strong>~71% vs Q4 2020 (9,740)</strong>.</li>
          </ul>
        </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This indicates the business did not just "sell cheaper" in late 2022 - it processed far fewer transactions.
</div> 

<br>
<li>Mid-Late 2022 is the Inflection Point (Where the Trend Becomes a Problem)
          <ul>
            <li>From mid-2022, order volume weakens (e.g., <strong>Jul 2,034 -&gt; Sep 1,553 -&gt; Oct 825</strong>).</li>
            <li>That drop aligns with the sharp revenue decline, which suggests conversion, traffic, availability, or customer retention issues intensified into Q4.</li>
          </ul>
        </li>
      </ol>

<strong>Why this matters to stakeholders</strong>
<ul>
        <li><strong>Growth/Marketing</strong>: Order count is the clearest "health signal" for acquisition + conversion. If orders fall while AOV is stable, the team may need to audit funnel performance (traffic, CVR), channel mix, and retention.</li>
        <li><strong>Customer/Operations</strong>: Fewer orders can also indicate customer experience friction (shipping delays, stockouts, returns/refunds perception) that reduces repeat purchasing.</li>
        <li><strong>Forecasting</strong>: Volume-driven downturns typically require different interventions than price-driven downturns - stakeholders need to know which lever to pull before spending budget in the wrong place.</li>
</ul>
</td>
</tr>
</table>






<!-- Product TRENDS -->
<h2 align="center">Product Performance</h2>
<div align="center">
<h3>Revenue is highly concentrated in a few core products, and the 2022 decline is broad-based across top products</h3>
<img width="1117" height="635" alt="ProductPerformance" src="https://github.com/user-attachments/assets/8fba3a40-66b4-4952-943c-291e9e5e8d2a" />
</div>

<table align="center">
<tr>
<td width="333" valign="top">
<h3>Revenue Concentration (Winners vs. Laggards)</h3>
<ul>
        <li><strong>Top 3 products drive ~85% of total revenue</strong> ($28.11M overall) - <strong>27in 4K gaming monitor ($9.85M)</strong>, <strong>Apple AirPods Headphones ($7.74M)</strong>, <strong>MacBook Air Laptop ($6.30M)</strong>.</li>
        <li><strong>ThinkPad Laptop ($3.21M)</strong> is the only meaningful tier-2 product; the remaining accessories are comparatively small (each under $0.45M).</li>
        <li><strong>Apple iPhone ($213K)</strong> and <strong>Bose SoundSport headphones ($3.3K)</strong> are extreme low performers for typically high-demand categories - this may indicate limited availability, incomplete catalog coverage, or data capture gaps.</li>
</ul>
</td>
  
<td width="333" valign="top">
    <h3>Momentum Shift (2020 Surge, 2022 Unwind)</h3>
      <ul>
        <li>Holiday performance expanded sharply in 2020: <strong>Q4 2020 revenue = $3.03M</strong> vs <strong>Q4 2019 = $1.18M</strong> (+158%), driven primarily by the top products.</li>
        <li>2022 breaks the historical pattern: <strong>Q4 2022 = $649K</strong>, down <strong>-72% vs Q4 2021 ($2.28M)</strong>, indicating a demand, supply, or tracking issue impacting multiple product lines at once.</li>
        <li>The drop is most severe in premium products: <strong>MacBook Air Q4 2022 is down ~83% vs Q4 2021</strong> ($86.6K vs $513.8K), suggesting higher price points are more exposed when consumer spending tightens.</li>
      </ul>
    </td>

<td width="333" valign="top">
      <h3>Heatmap Takeaways (Seasonality and Execution Risk)</h3>
      <ul>
        <li>Recurring <strong>Q4 spikes</strong> across major products suggest promotions and holiday demand are key revenue drivers - stakeholders may need to align inventory planning and marketing spend tightly ahead of peak season.</li>
        <li>Post-holiday softness in early quarters appears consistently, indicating seasonality - a strong lever here is retention (bundles, add-ons, and reactivation campaigns) to stabilize Q1-Q2 volume.</li>
        <li>Because revenue is concentrated, <strong>stockouts, pricing changes, or channel tracking issues on 1-2 top products can materially move company-wide sales</strong> - leadership should monitor these products as “business-critical” health indicators.</li>
      </ul>
    </td>
  </tr>
</table>

<div align="center">
<h3>Product Sales Heat Map by Quarter</h3>
<img width="728" height="302" alt="ProductHeatMap1" src="https://github.com/user-attachments/assets/169eb1e1-0187-4855-a499-c0fbd8b6f14d" />
</div>
<br>


<!-- LOYALTY -->
<h2 align="center">Loyalty Program</h2>
<h3> Loyalty vs Non-Loyalty: AOV and Order Volume Trends (2019–2022) </h3>
<div>
<img width="1148" height="977" alt="LvsNL" src="https://github.com/user-attachments/assets/e0d4ea0b-6683-4649-9f66-c66438200b29" />
</div>

<br>
<ul>
  <li>
    <strong>Loyalty scales order frequency without shrinking basket size</strong> - a strong signal the program isn’t growing purely from discounts.
    <ul>
      <li>As monthly Loyalty orders ramp into the <strong>thousands</strong> during 2020-2021, Loyalty AOV rebounds from the early low (~<strong>$130</strong>) and stabilizes around the <strong>mid-$200s</strong> (peaking near <strong>$259</strong>).</li>
    </ul>
  </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This indicates Loyalty growth is driven by <strong>repeat purchasing</strong> and a healthier customer mix, not just “cheap incentive orders” that typically drag AOV down.
</div>

<br>

  <li>
    <strong>Non-loyal behaves like a spike-driven segment</strong> - when demand cools, both frequency and basket value compress.
    <ul>
      <li>Non-loyal AOV peaks around <strong>$384</strong> during the 2020 boom, then trends down toward the <strong>low-$200s</strong> by 2022, while monthly order volume also declines later in the period.</li>
    </ul>
  </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This suggests non-loyal revenue is more exposed to <strong>macro conditions</strong>, <strong>acquisition bursts</strong>, and <strong>promotion cycles</strong>, creating higher volatility.
</div>

<br>
  <li>
    <strong>The clearest “loyalty value” moments are when orders are similar but Loyalty AOV is materially higher</strong>.
    <ul>
      <li><strong>Jun 2022</strong>: orders are nearly identical (<strong>935 Non-loyal</strong> vs <strong>962 Loyalty</strong>), but AOV is <strong>$182</strong> vs <strong>$260</strong> (Loyalty ~<strong>43%</strong> higher).</li>
      <li><strong>Aug 2022</strong>: orders are almost the same (<strong>914</strong> vs <strong>920</strong>), but AOV is <strong>$187</strong> vs <strong>$246</strong> (Loyalty ~<strong>31%</strong> higher).</li>
    </ul>
  </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> This indicates Loyalty members are buying <strong>higher-priced items</strong> and/or <strong>larger bundles</strong>, signaling stronger customer quality and likely higher LTV.</div>

<br>
  <li>
    <strong>Late-2022 shows a broad volume decline across both segments</strong> - worth monitoring, but the Loyalty value signal remains.
    <ul>
      <li>Both order lines compress sharply in late 2022, suggesting a broader business issue (demand slowdown, inventory constraints, channel performance, or tracking).</li>
    </ul>
  </li>
<div style="margin-left: 22px;">
<span style="font-size: 18px; font-weight: 700;">➤</span> Even in this environment, the “similar orders + higher Loyalty AOV” pattern earlier in 2022 suggests the program acts as a <strong>revenue-quality stabilizer</strong> rather than just a discount engine.
</div>

</ul>

<br>

















<!-- Region -->
 <h2 align="center">Region Results</h2>     
<div >
<img width="960" height="518" alt="image" src="https://github.com/user-attachments/assets/b5c28558-026c-4031-adc4-ff86c708e712" />
</div>      




<!-- REFUNDS -->
<h2 align="center">Refunds</h2>
<table align="center">
  <tr>
    <td width="500" align="center">
      <h2 align="center">Refund Rate per Product Type</h2> 
      <img width="657" height="291" alt="refundrate" src="https://github.com/user-attachments/assets/1fdf0fb2-731b-451d-b7ac-0abd8c16b5b1" />
    </td>
    <td width="500" align="center">
        <ul>
          <li></li>
          <li></li>
          <li></li>
        </ul>
      </td>
    
  </tr>
</table>







<!-- RECOMMENDATIONS -->
<h1>Recommendations</h1>
<h4>Actionable next steps based on the insights above.</h4>
<ul>
  <h3>Sales</h3>
  <li>[Recommendation #1]</li>
  <li>[Recommendation #2]</li>

  <h3>Loyalty Program</h3>
  <li>[Recommendation #1]</li>
  <li>[Recommendation #2]</li>

  <h3>Refunds</h3>
  <li>[Recommendation #1]</li>

  <h3>Regions</h3>
  <li>[Recommendation #1]</li>
</ul>
