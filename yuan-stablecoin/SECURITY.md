# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in the YuanCoin smart contract, please report it responsibly:

1. **DO NOT** open a public issue
2. Email the details to: [your-security-email@example.com]
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Security Best Practices

### For Administrators

1. **Private Key Management**
   - Never share or commit private keys
   - Use hardware wallets for mainnet deployments
   - Consider using multi-signature wallets for admin roles

2. **Role Management**
   - Regularly audit who has MINTER_ROLE, PAUSER_ROLE, and BLACKLISTER_ROLE
   - Use the principle of least privilege
   - Consider time-locked role changes for critical operations

3. **Monitoring**
   - Monitor all minting events
   - Set up alerts for large transfers
   - Regularly check blacklist additions
   - Monitor pause/unpause events

4. **Reserve Management**
   - Maintain 1:1 backing with CNY reserves
   - Regular third-party audits of reserves
   - Transparent reporting of reserve status

### For Users

1. **Verify Contract Address**
   - Always verify you're interacting with the official contract
   - Check multiple sources for the correct address
   - Be wary of phishing attempts

2. **Transaction Safety**
   - Double-check recipient addresses
   - Verify transaction details before signing
   - Use reputable wallets

## Known Limitations

1. **Centralization**: The contract has admin roles that can mint, pause, and blacklist. This is by design for regulatory compliance but introduces centralization risks.

2. **Upgradability**: This version is not upgradeable. Any bugs require a new deployment and token migration.

3. **Regulatory Risk**: Stablecoins face regulatory scrutiny. Ensure compliance with local laws.

## Audit Status

⚠️ **This contract has not been professionally audited yet.**

Before mainnet deployment, we strongly recommend:
- Professional security audit by firms like OpenZeppelin, Trail of Bits, or Consensys Diligence
- Bug bounty program
- Extensive testnet testing

## Emergency Procedures

In case of a security incident:

1. **Immediate Response**
   - Pause the contract using PAUSER_ROLE
   - Assess the situation
   - Notify users through official channels

2. **Investigation**
   - Determine the scope of the incident
   - Identify affected addresses
   - Document all findings

3. **Resolution**
   - Implement fixes
   - Consider migration to new contract if necessary
   - Compensate affected users if applicable

4. **Post-Mortem**
   - Publish incident report
   - Implement preventive measures
   - Update security procedures

## Contact

For security concerns: [your-security-email@example.com]

For general inquiries: [your-general-email@example.com]
